import 'dart:io';

import 'package:app_warehouse/config/http_overrides.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider<User>(
      create: (_) => User.empty(), child: MyApp()));
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
