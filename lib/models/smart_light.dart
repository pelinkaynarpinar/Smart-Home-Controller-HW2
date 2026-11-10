import 'connectable.dart';
import 'schedulable.dart';
import 'smart_device.dart';

/// Inheritance + mixin + interface in the same class.
class SmartLight extends SmartDevice with Schedulable implements Connectable {
  bool isOn;
  double brightness;
  bool _connected;

  // Unnamed (default) constructor, using `this` to initialize fields.
  SmartLight({
    required String name,
    required String room,
    this.isOn = true,
    this.brightness = 75,
  })  : _connected = true,
        super(name: name, room: room);

  // Named constructor for a light which is initially switched off.
  SmartLight.off({required String name, required String room})
      : isOn = false,
        brightness = 50,
        _connected = true,
        super(name: name, room: room);

  @override
  bool get isConnected => _connected;

  @override
  void connect() => _connected = true;

  @override
  void disconnect() => _connected = false;

  void togglePower(bool value) {
    if (isConnected) isOn = value;
  }

  void setBrightness(double value) {
    if (isConnected && isOn) brightness = value.clamp(0.0, 100.0).toDouble();
  }

  @override
  String getStatus() {
    if (!isConnected) return 'Disconnected';
    return isOn ? 'ON' : 'OFF';
  }
}
