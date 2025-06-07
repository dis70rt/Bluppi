package `in`.ethernode.synqit

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.net.toUri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.media3.common.MediaItem
import androidx.media3.common.MediaMetadata
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.session.MediaSession
import androidx.media3.ui.PlayerNotificationManager

@UnstableApi
class MainActivity: FlutterActivity() {
    private lateinit var exoPlayer: ExoPlayer
    private lateinit var mediaSession: MediaSession
    private lateinit var notificationManager: PlayerNotificationManager

    private val CHANNEL_NAME = "synqit/media_channel"
    private val NOTIFICATION_ID = 1001
    private val NOTIFICATION_CHANNEL_ID = "synqit_player_channel"



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        createNotificationChannel()
        initPlayer()

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "play" -> {
                    val url      = call.argument<String>("url")      ?: error("no url")
                    val title    = call.argument<String>("title")    ?: "Unknown title"
                    val artist   = call.argument<String>("artist")   ?: "Unknown artist"
                    val imageUrl = call.argument<String>("imageUrl") ?: ""

                    // 1. Build MediaMetadata
                    val mediaMetadata = MediaMetadata.Builder()
                        .setTitle(title)
                        .setArtist(artist)
                        // If you have a Uri for artwork:
                        .setArtworkUri(imageUrl.toUri())
                        .build()

                    // 2. Build MediaItem with metadata
                    val mediaItem = MediaItem.Builder()
                        .setUri(url)
                        .setMediaMetadata(mediaMetadata)
                        .build()

                    // 3. Play it
                    exoPlayer.setMediaItem(mediaItem)
                    exoPlayer.prepare()
                    exoPlayer.play()
                    result.success(null)
                }

                "pause" -> {
                    exoPlayer.pause()
                    result.success(null)
                }
                "stop" -> {
                    exoPlayer.stop()
                    result.success(null)
                }
                "seekTo" -> {
                    val pos = call.argument<Int>("position") ?: 0
                    exoPlayer.seekTo(pos.toLong())
                    result.success(null)
                }
                "getPosition" -> {
                    result.success(exoPlayer.currentPosition)
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

    private fun playUrl(url: String) {
        val mediaItem = MediaItem.fromUri(url)
        exoPlayer.setMediaItem(mediaItem)
        exoPlayer.prepare()
        exoPlayer.play()
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
