import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'widgets/login_perf_test.dart';

void main() async {
  try {
    await initializeTest();
    FlutterError.onError = (details) {
      log(details.exception.toString());
    };
  } catch (ex) {
    log(ex.toString());
  }
}

Future<void> initializeTest() async {
  final testBinding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group("Login Perf Test Group", skip: false, () {
    loginTest(testBinding);
  });



}
