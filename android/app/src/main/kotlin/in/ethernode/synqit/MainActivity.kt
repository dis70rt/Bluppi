package `in`.ethernode.synqit

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.net.toUri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import androidx.media3.common.MediaItem
import androidx.media3.common.MediaMetadata
import androidx.media3.common.Player
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.session.MediaSession
import androidx.media3.ui.PlayerNotificationManager

@UnstableApi
class MainActivity: FlutterActivity() {
    private lateinit var exoPlayer: ExoPlayer
    private lateinit var mediaSession: MediaSession
    private lateinit var notificationManager: PlayerNotificationManager
    private var eventSink: EventChannel.EventSink? = null

    private val CHANNEL_NAME = "synqit/media_channel"
    private val PLAYBACK_EVENTS = "synqit/media_events"
    private val NOTIFICATION_ID = 1001
    private val NOTIFICATION_CHANNEL_ID = "synqit_player_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannel()
        initPlayer()

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, PLAYBACK_EVENTS)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    eventSink = events
                    exoPlayer.addListener(playerListener)
                }
                override fun onCancel(arguments: Any?) {
                    exoPlayer.removeListener(playerListener)
                    eventSink = null
                }
            })

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "play" -> {
                        val url      = call.argument<String>("url")      ?: error("no url")
                        val title    = call.argument<String>("title")    ?: "Unknown title"
                        val artist   = call.argument<String>("artist")   ?: "Unknown artist"
                        val imageUrl = call.argument<String>("imageUrl") ?: ""

                        val mediaMetadata = MediaMetadata.Builder()
                            .setTitle(title)
                            .setArtist(artist)
                            .setArtworkUri(imageUrl.toUri())
                            .build()

                        val mediaItem = MediaItem.Builder()
                            .setUri(url)
                            .setMediaMetadata(mediaMetadata)
                            .build()

                        exoPlayer.setMediaItem(mediaItem)
                        exoPlayer.prepare()
                        exoPlayer.play()
                        result.success(null)
                    }
                    "pause" -> {
                        exoPlayer.pause(); result.success(null)
                    }
                    "stop" -> {
                        exoPlayer.stop(); result.success(null)
                    }
                    "seekTo" -> {
                        val pos = call.argument<Int>("position") ?: 0
                        exoPlayer.seekTo(pos.toLong()); result.success(null)
                    }
                    "getPosition" -> {
                        result.success(exoPlayer.currentPosition)
                    }
                    "prewarm" -> {
                        val nextUrl      = call.argument<String>("url")      ?: error("no url")
                        val nextTitle    = call.argument<String>("title")    ?: "Unknown title"
                        val nextArtist   = call.argument<String>("artist")   ?: "Unknown artist"
                        val nextImageUrl = call.argument<String>("imageUrl") ?: ""

                        val nextMetadata = MediaMetadata.Builder()
                            .setTitle(nextTitle)
                            .setArtist(nextArtist)
                            .setArtworkUri(nextImageUrl.toUri())
                            .build()
                        val nextItem = MediaItem.Builder()
                            .setUri(nextUrl)
                            .setMediaMetadata(nextMetadata)
                            .build()

                        exoPlayer.addMediaItem(nextItem)
                        exoPlayer.prepare()
                        result.success(true)
                    }
                    "skipToNext" -> {
                        val nextIndex = exoPlayer.currentMediaItemIndex + 1
                        if (nextIndex < exoPlayer.mediaItemCount) {
                            exoPlayer.seekTo(nextIndex, 0L)
                            exoPlayer.play()
                            result.success(null)
                        } else result.error("NO_NEXT","No next item",null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun initPlayer() {
        exoPlayer = ExoPlayer.Builder(this).build()
        mediaSession = MediaSession.Builder(this, exoPlayer).build()
        notificationManager = PlayerNotificationManager.Builder(
            this,
            NOTIFICATION_ID,
            NOTIFICATION_CHANNEL_ID
        )
            .setChannelNameResourceId(R.string.notification_channel_name)
            .setChannelDescriptionResourceId(R.string.notification_channel_desc)
            .build()

        notificationManager.setPlayer(exoPlayer)
        notificationManager.setMediaSessionToken(mediaSession.platformToken)
    }

    private val playerListener = object : Player.Listener {
        override fun onPlaybackStateChanged(state: Int) {
            val stateStr = when (state) {
                Player.STATE_IDLE      -> "idle"
                Player.STATE_BUFFERING -> "buffering"
                Player.STATE_READY     -> {
                    if (exoPlayer.duration > 0) {
                        eventSink?.success(mapOf(
                            "event" to "duration",
                            "duration" to exoPlayer.duration
                        ))
                    }
                    "ready"
                }
                Player.STATE_ENDED     -> "ended"
                else                   -> "unknown"
            }
            eventSink?.success(mapOf("event" to "state", "state" to stateStr))
        }

        override fun onIsPlayingChanged(isPlaying: Boolean) {
            eventSink?.success(mapOf("event" to "playing", "playing" to isPlaying))
        }

        override fun onPositionDiscontinuity(reason: Int) {
            eventSink?.success(mapOf("event" to "seek", "position" to exoPlayer.currentPosition))
        }

        override fun onMediaMetadataChanged(metadata: MediaMetadata) {
            if (exoPlayer.duration > 0) {
                eventSink?.success(mapOf(
                    "event" to "duration",
                    "duration" to exoPlayer.duration
                ))
            }
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                getString(R.string.notification_channel_name),
                NotificationManager.IMPORTANCE_LOW
            )
            channel.description = getString(R.string.notification_channel_desc)
            val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            manager.createNotificationChannel(channel)
        }
    }

    override fun onDestroy() {
        notificationManager.setPlayer(null)
        mediaSession.release()
        exoPlayer.release()
        super.onDestroy()
    }
}