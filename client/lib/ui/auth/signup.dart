import 'dart:convert';

import 'package:bonus/api/auth/auth.dart';
import 'package:bonus/api/user/user.dart';
import 'package:bonus/model/token.dart';
import 'package:bonus/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _name;
  late TextEditingController _firstname;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _firstname = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _firstname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
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
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _firstname,
              decoration: const InputDecoration(hintText: 'firstname'),
            ),
            Container(
              height: 30,
            ),
            TextField(
              controller: _name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            Container(
              height: 30,
            ),
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
                  registerUser(_email.text, _name.text, _firstname.text,
                          _password.text)
                      .then((value) async {
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
