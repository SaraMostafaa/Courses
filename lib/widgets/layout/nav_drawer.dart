// ignore_for_file: prefer_const_constructors

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
              title: Text('Home'),
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
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
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
            title: Text('Logout'),
            onTap: () => {FirebaseAuth.instance.signOut()},
          ),
        ],
      ),
    );
  }
}
