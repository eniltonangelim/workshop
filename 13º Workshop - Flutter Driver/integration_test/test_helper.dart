import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelper {
  static late WidgetTester tester;

  static Future<void> pumpApp(Widget app) async {
    await tester.pumpWidget(app);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }

  static Future<void> enterDataInTextField(
      {required Finder finder, required String data}) async {
    try {
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      await tester.tap(finder, warnIfMissed: false);
      await tester.enterText(finder, data);
      await tester.pumpAndSettle();
    } catch (ex) {
      log(ex.toString());
    }
  }

  static Future<void> tapOnButton({required Finder finder}) async {
    try {
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      await tester.tap(finder, warnIfMissed: false);
      await tester.pumpAndSettle();
    } catch (ex) {
      log(ex.toString());
    }
  }
}
