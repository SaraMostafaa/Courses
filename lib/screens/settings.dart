// ignore_for_file: prefer_const_constructors

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SettingsGroup(
              title: "General",
              children: <Widget>[
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

Widget buildLogout() => SimpleSettingsTile(
      title: "Logout",
      subtitle: "",
      leading: Icon(Icons.exit_to_app),
      onTap: () => {FirebaseAuth.instance.signOut()},
    );
