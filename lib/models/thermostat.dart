import 'connectable.dart';
import 'smart_device.dart';

class Thermostat extends SmartDevice implements Connectable {
  int currentTemperature;
  int targetTemperature;
  bool _connected;

  Thermostat({
    required String name,
    required String room,
    this.currentTemperature = 20,
    this.targetTemperature = 22,
  })  : _connected = true,
        super(name: name, room: room);

  @override
  bool get isConnected => _connected;

  @override
  void connect() => _connected = true;

  @override
  void disconnect() => _connected = false;

  void increaseTemperature() {
    if (isConnected && targetTemperature < 30) targetTemperature++;
  }

  void decreaseTemperature() {
    if (isConnected && targetTemperature > 16) targetTemperature--;
  }

  @override
  String getStatus() {
    if (!isConnected) return 'Disconnected';
    if (targetTemperature > currentTemperature) return 'Heating';
    if (targetTemperature < currentTemperature) return 'Cooling';
    return 'Idle';
  }
}
