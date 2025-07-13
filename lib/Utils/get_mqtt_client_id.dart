import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _mqttClientIdKey = 'mqtt-client-id';
final Future<SharedPreferences> _prefsFuture = SharedPreferences.getInstance();
String? _cachedClientId;
final _uuid = Uuid();

Future<String> getMqttClientId() async {
  if (_cachedClientId != null) return _cachedClientId!;
  final prefs = await _prefsFuture;

  final storedId = prefs.getString(_mqttClientIdKey);
  if (storedId != null && storedId.isNotEmpty) {
    _cachedClientId = storedId;
    return storedId;
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final newClientId = 'bluppi-$userId-${_uuid.v4()}';
  await prefs.setString(_mqttClientIdKey, newClientId);
  _cachedClientId = newClientId;
  return newClientId;
}
