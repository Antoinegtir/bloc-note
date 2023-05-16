import 'package:bonus/ui/auth/signin.dart';
import 'package:bonus/ui/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Epytodo",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Connection\nMethod",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 55,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 70,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SignUpPage(),
                        ),
                      );
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
                Container(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SignInPage(),
                        ),
                      );
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: Colors.black,
                          height: 70,
                          width: 250,
                          alignment: Alignment.center,
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                        )))
              ],
            )));
  }
}
