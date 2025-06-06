package `in`.ethernode.synqit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL_ID = "music_playback_channel"
    private val NOTIFICATION_ID = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val CHANNEL_NAME = "synqit/media_channel"

        createNotificationChannel(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "showMusicNotification" -> {
                        val id = call.argument<String>("trackId")
                        val title = call.argument<String>("title")
                        val artist = call.argument<String>("artist")
                        val imageUrl = call.argument<String>("imageUrl")
                        val isPlaying = call.argument<Boolean>("isPlaying")
                    }

                    else -> {
                    }

                }
            }
    }
}