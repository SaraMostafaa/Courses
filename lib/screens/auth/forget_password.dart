import 'package:courses/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  passwordReset() async {
    final _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgetPasswordTitle),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.forgetPasswordSubtitle,
                      style: TextStyle(fontSize: 15),
                    ),
                    TextFormField(
                      onSaved: (_) => {
                        (value) {
                          emailController.text = value!;
                        },
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: l10n.forgetPasswordEmail,
                        icon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RaisedButton(
                      child: Text(l10n.forgetPasswordSend),
                      onPressed: () {
                        passwordReset();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
