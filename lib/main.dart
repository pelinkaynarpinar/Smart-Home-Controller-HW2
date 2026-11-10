import 'package:flutter/material.dart';

import 'models/connectable.dart';
import 'models/smart_device.dart';
import 'models/smart_light.dart';
import 'models/smart_speaker.dart';
import 'models/thermostat.dart';

void main() => runApp(const SmartHomeApp());

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Controller',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF425BC7)),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<SmartDevice> _devices;

  @override
  void initState() {
    super.initState();
    // Objects: five instances from three different subclasses.
    // Both unnamed and named constructors are used here.
    _devices = [
      SmartLight(name: 'Living Room Light', room: 'Living Room', brightness: 75),
      SmartLight.off(name: 'Kitchen Light', room: 'Kitchen'),
      Thermostat(
        name: 'Bedroom Thermostat',
        room: 'Bedroom',
        currentTemperature: 20,
        targetTemperature: 22,
      ),
      SmartSpeaker(name: 'Kitchen Speaker', room: 'Kitchen', volume: 40),
      SmartSpeaker.playing(name: 'Office Speaker', room: 'Office', volume: 25),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  if (device is SmartLight) return _buildLightCard(device);
                  if (device is Thermostat) return _buildThermostatCard(device);
                  if (device is SmartSpeaker) return _buildSpeakerCard(device);
                  return const SizedBox.shrink();
                },
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF425BC7),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(Icons.home_rounded, color: Colors.white, size: 29),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SMART HOME',
                  style: TextStyle(
                    color: Color(0xFF63708D),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Control Center',
                  style: TextStyle(
                    color: Color(0xFF17213E),
                    fontWeight: FontWeight.w800,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_devices.length} devices',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF425BC7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5EAF2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Devices',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          Text(
            '${SmartDevice.totalDevices}', // Required static variable.
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF425BC7),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleConnection(Connectable device) {
    setState(() {
      if (device.isConnected) {
        device.disconnect();
      } else {
        device.connect();
      }
    });
  }

  Widget _buildShell({
    required SmartDevice device,
    required Connectable connection,
    required IconData icon,
    required Color accent,
    required Widget controls,
  }) {
    final connected = connection.isConnected;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7EBF4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C1F2D5D),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 25),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17213E),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      device.room,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7A8499),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: connected ? 'Disconnect device' : 'Connect device',
                onPressed: () => _toggleConnection(connection),
                icon: Icon(
                  connected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                  color: connected ? const Color(0xFF2B9A71) : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 8,
                color: connected ? const Color(0xFF2B9A71) : Colors.grey,
              ),
              const SizedBox(width: 7),
              Text(
                'Status: ${device.getStatus()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: connected ? const Color(0xFF2B9A71) : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF0F2F7)),
          const SizedBox(height: 12),
          controls,
        ],
      ),
    );
  }

  Widget _buildLightCard(SmartLight light) {
    return _buildShell(
      device: light,
      connection: light,
      icon: Icons.lightbulb_rounded,
      accent: const Color(0xFFE3A52A),
      controls: Column(
        children: [
          Row(
            children: [
              const Text('Power', style: TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Switch(
                value: light.isOn,
                onChanged: light.isConnected
                    ? (value) => setState(() => light.togglePower(value))
                    : null,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Brightness', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('${light.brightness.round()}%'),
            ],
          ),
          Slider(
            value: light.brightness,
            min: 0,
            max: 100,
            divisions: 20,
            onChanged: light.isConnected && light.isOn
                ? (value) => setState(() => light.setBrightness(value))
                : null,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: light.isConnected
                  ? () => setState(() {
                        if (light.scheduledAt == null) {
                          light.scheduleFor(DateTime.now().add(const Duration(hours: 1)));
                        } else {
                          light.clearSchedule();
                        }
                      })
                  : null,
              icon: const Icon(Icons.schedule_rounded, size: 18),
              label: Text(
                light.scheduledAt == null
                    ? 'Plan a toggle (+1 hour)'
                    : 'Planned for ${TimeOfDay.fromDateTime(light.scheduledAt!).format(context)} (clear)',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThermostatCard(Thermostat thermostat) {
    return _buildShell(
      device: thermostat,
      connection: thermostat,
      icon: Icons.thermostat_rounded,
      accent: const Color(0xFFE86B60),
      controls: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Target Temperature', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                Text(
                  'Current: ${thermostat.currentTemperature}°C',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF7A8499)),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            tooltip: 'Decrease temperature',
            onPressed: thermostat.isConnected && thermostat.targetTemperature > 16
                ? () => setState(thermostat.decreaseTemperature)
                : null,
            icon: const Icon(Icons.remove_rounded),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '${thermostat.targetTemperature}°',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
          IconButton.filledTonal(
            tooltip: 'Increase temperature',
            onPressed: thermostat.isConnected && thermostat.targetTemperature < 30
                ? () => setState(thermostat.increaseTemperature)
                : null,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerCard(SmartSpeaker speaker) {
    return _buildShell(
      device: speaker,
      connection: speaker,
      icon: Icons.speaker_rounded,
      accent: const Color(0xFF6C69CE),
      controls: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Playback', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              FilledButton.tonalIcon(
                onPressed: speaker.isConnected
                    ? () => setState(speaker.togglePlayback)
                    : null,
                icon: Icon(speaker.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
                label: Text(speaker.isPlaying ? 'Pause' : 'Play'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Volume', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('${speaker.volume.round()}%'),
            ],
          ),
          Slider(
            value: speaker.volume,
            min: 0,
            max: 100,
            divisions: 20,
            onChanged: speaker.isConnected
                ? (value) => setState(() => speaker.setVolume(value))
                : null,
          ),
        ],
      ),
    );
  }
}
