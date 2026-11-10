
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_controller/main.dart';

void main() {
  testWidgets('Smart Home UI and light interaction test', (tester) async {
    await tester.pumpWidget(const SmartHomeApp());

    // Check the main UI elements.
    expect(find.text('Control Center'), findsOneWidget);
    expect(find.text('Living Room Light'), findsOneWidget);
    expect(find.text('Total Devices'), findsOneWidget);

    // Check the light switch.
    final lightSwitch = find.byType(Switch).first;
    expect(tester.widget<Switch>(lightSwitch).value, isTrue);

    // Turn the light off.
    await tester.tap(lightSwitch);
    await tester.pumpAndSettle();

    // Verify that the switch is now off.
    expect(
      tester.widget<Switch>(find.byType(Switch).first).value,
      isFalse,
    );
  });
}
