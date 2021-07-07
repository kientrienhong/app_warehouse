import 'dart:io';

import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';

import '/config/http_overrides.dart';
import '/models/entity/user.dart';
import '/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<User>(
        create: (_) => User.empty(),
      ),
      ChangeNotifierProvider<Storage>(
        create: (_) => Storage.empty(),
      ),
      ChangeNotifierProvider<Shelf>(
        create: (_) => Shelf.empty(),
      ),
    ],
    child: MyApp(),
  ));
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
