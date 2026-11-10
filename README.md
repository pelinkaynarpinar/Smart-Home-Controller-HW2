# BIM493 Mobile Programming I — Assignment 2

## Smart Home Controller App

### Team Members

| Full Name | Student ID |
| --- | --- |
| Pelin Kaynarpınar | 
| Zeynep Zişan Beylen |

**Project Type:** Group assignment (2 students)

A simple interactive Flutter app for managing smart home devices. Built using Dart object-oriented programming concepts.

## Features

- **Smart Light**: on/off switch, brightness slider, scheduled-toggle time (stored in memory).
- **Thermostat**: target-temperature + / - buttons with 16–30 °C limits, heating/cooling/idle status.
- **Smart Speaker**: play/pause button and volume slider.
- **Connection**: the Wi-Fi icon on each card connects or disconnects that device.
- **Total Devices**: the footer uses the static `SmartDevice.totalDevices` counter (5 devices created at launch).

This is a **simulation**: no physical hardware, music playback, background scheduling, or persistent storage is implemented. Schedule actions only store/clear the planned time.

## Setup and run

Flutter SDK (Dart 3.3+) and Chrome or a supported device are required.

This ZIP contains the hand-written Flutter project source. To generate the platform runner folders that Flutter normally creates:

```powershell
cd smart_home_controller
flutter create --project-name smart_home_controller --platforms=web,android .
flutter pub get
flutter run -d chrome
```

Run all model and widget tests with:

```powershell
flutter test
```

If `flutter` is not recognized, install/configure the Flutter SDK and add `flutter/bin` to your PATH first, then run `flutter doctor`.

## OOP requirements mapping

| Requirement | Implementation |
| --- | --- |
| Class | `SmartDevice`, `SmartLight`, `Thermostat`, `SmartSpeaker` |
| Objects | Five instances in `lib/main.dart` > `initState()` |
| Default + named constructors | `SmartLight(...)`, `SmartLight.off(...)`, `SmartSpeaker.playing(...)` |
| Inheritance | `extends SmartDevice` in all 3 device subclasses |
| Abstraction | `abstract class SmartDevice` and `String getStatus()` |
| Interface | `Connectable` implemented by all 3 subclasses |
| Mixin | `Schedulable` used by `SmartLight` |
| `static` | `SmartDevice.totalDevices` |
| `super` | Subclass constructors call `super(name: ..., room: ...)` |
| `this` | Class fields initialized using `this.isOn`, `this.brightness`, etc. |
| Required UI | Cards, device information, controls, and footer counter in `lib/main.dart` |

## Project files

```
lib/
  main.dart
  models/
    connectable.dart
    schedulable.dart
    smart_device.dart
    smart_light.dart
    thermostat.dart
    smart_speaker.dart
test/
  device_model_test.dart
  widget_test.dart
pubspec.yaml
README.md
```

All device data is in memory and resets when the application restarts.
