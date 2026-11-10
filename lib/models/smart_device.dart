/// The common foundation for all devices in the smart home.
abstract class SmartDevice {
  // Class-level counter, shared by every subclass.
  static int totalDevices = 0;

  final String name;
  final String room;

  SmartDevice({required this.name, required this.room}) {
    totalDevices++;
  }

  // Every specific device must provide its own status.
  String getStatus();
}
