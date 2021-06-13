import 'dart:io';

import 'package:app_warehouse/config/http_overrides.dart';
import 'package:app_warehouse/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Helvetica'),
      home: LogInScreen(),
    );
  }
}
