// ignore_for_file: deprecated_member_use

import 'package:courses/generated/l10n.dart';
import 'package:courses/screens/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'dart:ui' as ui;

import 'screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => S.of(context).pageTitle,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(95, 158, 160, 1.0),
          fontFamily: "QuickSand",
          //primarySwatch: Colors.blue,
          backgroundColor: Colors.blueAccent,
          //accentColor: Colors.blue[300],
          accentColorBrightness: Brightness.dark,
          accentColor: Color.fromRGBO(47, 79, 79, 1.0),
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Color.fromRGBO(95, 158, 160, 1.0),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.blue[300])),
      initialRoute: "/",
      home: Directionality(
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasData) {
                return Home();
              } else {
                return AuthScreen();
              }
            },
          ),
          textDirection: S.isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
