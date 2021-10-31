// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:courses/generated/l10n.dart';
import 'package:courses/screens/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(l10n.settings),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SettingsGroup(
              title: l10n.general,
              children: const <Widget>[
                Account(),
                //buildLogout(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLogout(BuildContext context) => SimpleSettingsTile(
      title: S.of(context).logout,
      subtitle: "",
      leading: Icon(Icons.exit_to_app),
      onTap: () => {FirebaseAuth.instance.signOut()},
    );
