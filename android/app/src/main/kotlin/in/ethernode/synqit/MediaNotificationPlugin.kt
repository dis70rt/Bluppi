package `in`.ethernode.synqit

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.net.toUri
import androidx.media3.common.MediaItem
import androidx.media3.common.MediaMetadata
import androidx.media3.common.Player
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.session.MediaSession
import androidx.media3.ui.PlayerNotificationManager
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import androidx.media3.common.C

@UnstableApi
class MediaNotificationPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel
    private var notificationManager: NotificationManager? = null
    private var mediaSession: MediaSession? = null
    private var player: ExoPlayer? = null
    private var playerNotificationManager: PlayerNotificationManager? = null

    private val NOTIFICATION_CHANNEL_ID = "media_playback_channel"
    private val NOTIFICATION_ID = 1000

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "synqit/media_notification")
        channel.setMethodCallHandler(this)

        notificationManager =
            context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Create Android O+ channel
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val chan = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "Media Playback",
                NotificationManager.IMPORTANCE_LOW
            ).apply { description = "Media playback controls" }
            notificationManager?.createNotificationChannel(chan)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showMusicNotification" -> {
                val mediaUri = call.argument<String>("mediaUri")!!
                val id = call.argument<String>("trackId")!!
                val title = call.argument<String>("title")!!
                val artist = call.argument<String>("artist")!!
                val album = call.argument<String>("album") ?: ""
                val imageUrl = call.argument<String>("imageUrl")!!
                val isPlaying = call.argument<Boolean>("isPlaying") ?: false
                val audioUrl = call.argument<String>("audioUrl") ?: mediaUri

                // Get the shared ExoPlayer instance or create a new one if needed
                player = ExoPlayerPlugin.player ?: ExoPlayer.Builder(context).build()

                // Initialize media session if needed
                if (mediaSession == null) {
                    mediaSession = MediaSession.Builder(context, player!!)
                        .setId("MediaNotificationSession")
                        .build()

                    // Configure player listener to relay events back to Flutter
                    player?.addListener(object : Player.Listener {
                        override fun onMediaItemTransition(mediaItem: MediaItem?, reason: Int) {
                            if (reason == Player.MEDIA_ITEM_TRANSITION_REASON_AUTO ||
                                reason == Player.MEDIA_ITEM_TRANSITION_REASON_SEEK) {
                                channel.invokeMethod("onMediaItemChanged", null)
                            }
                        }
                    })
                }

                // Set up the notification manager if it hasn't been already
                if (playerNotificationManager == null) {
                    playerNotificationManager = PlayerNotificationManager.Builder(
                        context,
                        NOTIFICATION_ID,
                        NOTIFICATION_CHANNEL_ID
                    )
                        .setMediaDescriptionAdapter(object : PlayerNotificationManager.MediaDescriptionAdapter {
                            override fun getCurrentContentTitle(player: Player) =
                                title

                            override fun createCurrentContentIntent(player: Player): PendingIntent? =
                                PendingIntent.getActivity(
                                    context,
                                    0,
                                    Intent(context, MainActivity::class.java),
                                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                                )

                            override fun getCurrentContentText(player: Player) =
                                artist

                            override fun getCurrentLargeIcon(
                                player: Player,
                                callback: PlayerNotificationManager.BitmapCallback
                            ): Bitmap? {
                                Glide.with(context)
                                    .asBitmap()
                                    .load(imageUrl)
                                    .into(object : CustomTarget<Bitmap>() {
                                        override fun onResourceReady(
                                            resource: Bitmap,
                                            transition: Transition<in Bitmap>?
                                        ) {
                                            callback.onBitmap(resource)
                                        }

                                        override fun onLoadCleared(placeholder: Drawable?) {}
                                    })
                                return null
                            }
                        })
                        .setNotificationListener(object : PlayerNotificationManager.NotificationListener {
                            override fun onNotificationCancelled(notificationId: Int, dismissedByUser: Boolean) {
                                channel.invokeMethod("onNotificationDismissed", null)
                            }

                            override fun onNotificationPosted(
                                notificationId: Int,
                                notification: android.app.Notification,
                                ongoing: Boolean
                            ) {
                                // Keep notification active
                                if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
                                    notificationManager?.notify(NOTIFICATION_ID, notification)
                                }
                            }
                        })
                        .setChannelNameResourceId(R.string.channel_name)
                        .setChannelDescriptionResourceId(R.string.channel_description)
                        .build().apply {
                            setMediaSessionToken(mediaSession!!.platformToken)
                            setUseNextAction(true)
                            setUsePreviousAction(true)
                            setUseStopAction(false)
                            setPlayer(player)
                        }
//                        .setMediaSessionToken(mediaSession!!.platformToken)
//                        .setUseNextAction(true)
//                        .setUsePreviousAction(true)
//                        .setUseStopAction(false)
//                        .setPlayer(player)

                }

                // set up the media item with the real audio URL
                val mediaItem = MediaItem.Builder()
                    .setMediaId(id)
                    .setUri(audioUrl.toUri())
                    .setMediaMetadata(
                        MediaMetadata.Builder()
                            .setTitle(title)
                            .setArtist(artist)
                            .setAlbumTitle(album)
                            .setArtworkUri(imageUrl.toUri())
                            .build()
                    )
                    .build()

                if (player?.currentMediaItem?.mediaId != id) {
                    player?.setMediaItem(mediaItem)
                    player?.prepare()
                }
                player?.playWhenReady = isPlaying

                result.success(null)
            }

            "updatePlaybackState" -> {
                val isPlaying = call.argument<Boolean>("isPlaying") ?: false
                player?.playWhenReady = isPlaying
                result.success(null)
            }

            "hideNotification" -> {
                playerNotificationManager?.setPlayer(null)
                mediaSession?.release()
                mediaSession = null
                playerNotificationManager = null
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        playerNotificationManager?.setPlayer(null)
        playerNotificationManager = null
        mediaSession?.release()
        mediaSession = null
    }
}