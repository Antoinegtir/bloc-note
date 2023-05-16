import 'dart:convert';

import 'package:bonus/api/auth/auth.dart';
import 'package:bonus/model/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../api/user/user.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            Container(
              height: 30,
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            Container(
              height: 50,
            ),
            GestureDetector(
                onTap: () async {
                  loginUser(_email.text, _password.text).then((value) async {
                    Map<String, dynamic> jsonMap = json.decode(value);
                    String token = jsonMap['token'];
                    setState(() {
                      Provider.of<TokenStates>(context, listen: false).token =
                          token;
                    });
                    getId(token).then((value) {
                      print(value);
                      setState(() {
                        Provider.of<TokenStates>(context, listen: false).id =
                            value;
                      });
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  });
                  // Navigator.pop(context);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.black,
                      height: 70,
                      width: 250,
                      alignment: Alignment.center,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                    ))),
          ])),
    );
  }
}
