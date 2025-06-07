package `in`.ethernode.synqit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

@androidx.media3.common.util.UnstableApi
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(ExoPlayerPlugin())
        flutterEngine.plugins.add(MediaNotificationPlugin())
    }
}