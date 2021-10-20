// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import '../auth/upload_form.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitInfo, this.isLoading);
  bool isLoading = false;

  final void Function(String email, String password, String userName,
      File image, bool isLogin, BuildContext context) submitInfo;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  String _email = "";
  String _userName = "";
  String _password = "";
  File? _userImage = new File(
      "https://images.assetsdelivery.com/compings_v2/pavelstasevich/pavelstasevich1811/pavelstasevich181101028.jpg");

  void pickedImage(File image) {
    _userImage = image;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("please pick image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitInfo(
          _email, _password, _userName, _userImage!, isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // Image(
                    //     image: AssetImage(
                    //       'assets/images/instructor-icon.png',
                    //     ),
                    //     width: 100,
                    //     height: 70,
                    //     fit: BoxFit.fill),
                    Text(
                      "Instructor",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (!isLogin) UserImagePicker(pickedImage),
                TextFormField(
                  key: ValueKey("email"),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email"),
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey("userName"),
                    decoration: const InputDecoration(labelText: "UserName"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a username.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a password.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _submit,
                    child: Text(
                      isLogin ? "Login" : "Register",
                    ),
                  ),
                FlatButton(
                  onPressed: (() {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  }),
                  child: Text(
                    isLogin ? "Register Now" : "Already have an account?",
                  ),
                  textColor: Theme.of(context).accentColor,
                )
              ],
            ),
          ),
          padding: const EdgeInsets.all(60),
        ),
      ),
    );
  }
}
