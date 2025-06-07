package `in`.ethernode.synqit

import android.content.Context
import android.net.Uri
import android.os.Handler
import android.os.Looper
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

@UnstableApi
class ExoPlayerPlugin : FlutterPlugin, MethodCallHandler {
    companion object { var player: ExoPlayer? = null }
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val handler = Handler(Looper.getMainLooper())
    private var positionUpdatesEnabled = false

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "synqit/exo_player")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                player ?: run {
                    player = ExoPlayer.Builder(context).build().apply {
                        addListener(object : Player.Listener {
                            override fun onPlaybackStateChanged(playbackState: Int) {
                                val stateMap = when (playbackState) {
                                    Player.STATE_IDLE -> "idle"
                                    Player.STATE_BUFFERING -> "buffering"
                                    Player.STATE_READY -> "ready"
                                    Player.STATE_ENDED -> "completed"
                                    else -> "unknown"
                                }
                                handler.post {
                                    channel.invokeMethod("onPlayerStateChanged", mapOf(
                                        "playing" to isPlaying,
                                        "processingState" to stateMap
                                    ))
                                }
                            }

                            override fun onIsPlayingChanged(isPlaying: Boolean) {
                                handler.post {
                                    channel.invokeMethod("onPlayerStateChanged", mapOf(
                                        "playing" to isPlaying,
                                        "processingState" to when (playbackState) {
                                            Player.STATE_IDLE -> "idle"
                                            Player.STATE_BUFFERING -> "buffering"
                                            Player.STATE_READY -> "ready"
                                            Player.STATE_ENDED -> "completed"
                                            else -> "unknown"
                                        }
                                    ))
                                }
                            }

                            override fun onPositionDiscontinuity(
                                oldPosition: Player.PositionInfo,
                                newPosition: Player.PositionInfo,
                                reason: Int
                            ) {
                                if (reason == Player.DISCONTINUITY_REASON_AUTO_TRANSITION ||
                                    reason == Player.DISCONTINUITY_REASON_SEEK) {
                                    handler.post {
                                        channel.invokeMethod("onCurrentIndexChanged", mapOf(
                                            "index" to currentMediaItemIndex
                                        ))
                                    }
                                }
                            }
                        })
                    }
                }
                startPositionUpdates()
                result.success(null)
            }

            "setAudioSource" -> {
                val uri = Uri.parse(call.argument<String>("uri")!!)
                player?.setMediaItem(MediaItem.fromUri(uri))
                player?.prepare()
                result.success(null)
            }

            "setAudioSources" -> {
                val audioSources = call.argument<List<Map<String, Any>>>("audioSources")!!
                val initialIndex = call.argument<Int>("initialIndex") ?: 0
                val preload = call.argument<Boolean>("preload") ?: true

                player?.clearMediaItems()

                // Add all media items
                audioSources.forEach { source ->
                    if (source["type"] == "uri") {
                        val uri = Uri.parse(source["uri"] as String)
                        player?.addMediaItem(MediaItem.fromUri(uri))
                    }
                }

                if (preload) {
                    player?.prepare()
                }

                // Set initial index if valid
                if (initialIndex >= 0 && initialIndex < audioSources.size) {
                    player?.seekToDefaultPosition(initialIndex)
                }

                // Update duration
                handler.post {
                    val duration = player?.duration
                    channel.invokeMethod("onDurationChanged", mapOf(
                        "duration" to (if (duration != C.TIME_UNSET) duration else null)
                    ))
                }

                result.success(null)
            }

            "play" -> {
                player?.play()
                result.success(null)
            }

            "pause" -> {
                player?.pause()
                result.success(null)
            }

            "stop" -> {
                player?.stop()
                result.success(null)
            }

            "seek" -> {
                val position = call.argument<Int>("position")!!
                val index = call.argument<Int>("index")
                if (index != null) {
                    player?.seekTo(index, position.toLong())
                } else {
                    player?.seekTo(position.toLong())
                }
                result.success(null)
            }

            "seekToNext" -> {
                if (player?.hasNextMediaItem() == true) {
                    player?.seekToNextMediaItem()
                    result.success(true)
                } else {
                    result.success(false)
                }
            }

            "seekToPrevious" -> {
                if (player?.hasPreviousMediaItem() == true) {
                    player?.seekToPreviousMediaItem()
                    result.success(true)
                } else {
                    result.success(false)
                }
            }

            "dispose" -> {
                stopPositionUpdates()
                player?.release()
                player = null
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    private fun startPositionUpdates() {
        positionUpdatesEnabled = true
        schedulePositionUpdate()
    }

    private fun stopPositionUpdates() {
        positionUpdatesEnabled = false
        handler.removeCallbacksAndMessages(null)
    }

    private fun schedulePositionUpdate() {
        if (!positionUpdatesEnabled) return

        handler.postDelayed({
            player?.let { exoPlayer ->
                channel.invokeMethod("onPositionChanged", mapOf(
                    "position" to exoPlayer.currentPosition
                ))

                channel.invokeMethod("onBufferedPositionChanged", mapOf(
                    "bufferedPosition" to exoPlayer.bufferedPosition
                ))

                if (exoPlayer.duration != C.TIME_UNSET) {
                    channel.invokeMethod("onDurationChanged", mapOf(
                        "duration" to exoPlayer.duration
                    ))
                }
            }

            schedulePositionUpdate()
        }, 500) // Update every 500ms
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stopPositionUpdates()
        channel.setMethodCallHandler(null)
        player?.release()
        player = null
    }
}