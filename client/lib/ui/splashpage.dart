import 'package:bonus/model/token.dart';
import 'package:bonus/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/onboard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TokenStates>(context);
    if (state.token == "") {
      return const OnBoardPage();
    } else {
      return const MyHomePage();
    }
  }
}
