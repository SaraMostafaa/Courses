import 'package:courses/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: S.of(context).accountSetting,
      subtitle: S.of(context).accountSubTitle,
      // ignore: prefer_const_constructors
      leading: Icon(
        Icons.person,
        color: Colors.blueGrey,
      ),
      child: SettingsScreen(
        children: [
          buildAccountInfo(context),
          buildSecurity(context),
          DropDownSettingsTile(
              title: S.of(context).accountSetting,
              settingKey: "key-language",
              subtitle: "",
              selected: 1,
              values: <int, String>{1: "English", 2: "العربية"},
              onChange: (language) => {
                    if (language == 1)
                      {
                        setState(() {
                          S.load(Locale("en"));
                        })
                      }
                    else
                      {
                        setState(() {
                          S.load(Locale("ar"));
                        })
                      }
                  }),
        ],
        title: S.of(context).accountSetting,
      ),
    );
  }
}

Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
      title: S.of(context).accountSecurity,
      subtitle: "",
      leading: Icon(Icons.security),
      onTap: () => {},
    );

Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
      title: S.of(context).accountInfo,
      subtitle: "",
      leading: Icon(Icons.text_snippet),
      onTap: () => {},
    );
