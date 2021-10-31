// ignore_for_file: prefer_const_constructors

import 'package:courses/generated/l10n.dart';
import 'package:courses/screens/home.dart';
import 'package:courses/screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  goto(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/drawer_logo.png'))),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text(S.of(context).sideMenuHome),
              onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return Home();
                        },
                      ),
                    )
                  }),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text(S.of(context).sideMenuProfile),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text(S.of(context).sideMenuSettings),
              onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return Settings();
                        },
                      ),
                    )
                  }),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(S.of(context).sideMenuLogout),
            onTap: () => {FirebaseAuth.instance.signOut()},
          ),
        ],
      ),
    );
  }
}
