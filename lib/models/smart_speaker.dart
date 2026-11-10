import 'connectable.dart';
import 'smart_device.dart';

class SmartSpeaker extends SmartDevice implements Connectable {
  bool isPlaying;
  double volume;
  bool _connected;

  SmartSpeaker({
    required String name,
    required String room,
    this.isPlaying = false,
    this.volume = 40,
  })  : _connected = true,
        super(name: name, room: room);

  // Another example of a named constructor.
  SmartSpeaker.playing({
    required String name,
    required String room,
    double volume = 25,
  })  : isPlaying = true,
        volume = volume,
        _connected = true,
        super(name: name, room: room);

  @override
  bool get isConnected => _connected;

  @override
  void connect() => _connected = true;

  @override
  void disconnect() => _connected = false;

  void togglePlayback() {
    if (isConnected) isPlaying = !isPlaying;
  }

  void setVolume(double value) {
    if (isConnected) volume = value.clamp(0.0, 100.0).toDouble();
  }

  @override
  String getStatus() {
    if (!isConnected) return 'Disconnected';
    return isPlaying ? 'Playing' : 'Paused';
  }
}
