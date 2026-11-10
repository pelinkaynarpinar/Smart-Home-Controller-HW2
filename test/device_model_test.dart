import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_controller/models/smart_device.dart';
import 'package:smart_home_controller/models/smart_light.dart';
import 'package:smart_home_controller/models/smart_speaker.dart';
import 'package:smart_home_controller/models/thermostat.dart';

void main() {
  test('Counts objects created by all subclasses', () {
    final before = SmartDevice.totalDevices;
    SmartLight(name: 'Test Light', room: 'Test Room');
    Thermostat(name: 'Test Thermostat', room: 'Test Room');
    SmartSpeaker.playing(name: 'Test Speaker', room: 'Test Room');
    expect(SmartDevice.totalDevices, before + 3);
  });

  test('Light can be toggled and scheduled', () {
    final light = SmartLight.off(name: 'Test', room: 'Kitchen');
    expect(light.getStatus(), 'OFF');
    light.togglePower(true);
    expect(light.getStatus(), 'ON');
    final plannedTime = DateTime(2026, 11, 10, 20);
    light.scheduleFor(plannedTime);
    expect(light.scheduledAt, plannedTime);
    light.clearSchedule();
    expect(light.scheduledAt, isNull);
  });

  test('Thermostat can adjust temperature with boundaries', () {
    final thermostat = Thermostat(name: 'Test', room: 'Bedroom', targetTemperature: 29);
    thermostat.increaseTemperature();
    thermostat.increaseTemperature();
    expect(thermostat.targetTemperature, 30);
    expect(thermostat.getStatus(), 'Heating');
    thermostat.disconnect();
    thermostat.decreaseTemperature();
    expect(thermostat.targetTemperature, 30);
    expect(thermostat.getStatus(), 'Disconnected');
  });

  test('Speaker can play/pause and change volume', () {
    final speaker = SmartSpeaker(name: 'Test', room: 'Office');
    expect(speaker.getStatus(), 'Paused');
    speaker.togglePlayback();
    speaker.setVolume(85);
    expect(speaker.getStatus(), 'Playing');
    expect(speaker.volume, 85);
  });
}
