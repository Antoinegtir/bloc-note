import 'dart:convert';

import 'package:bonus/api/user/user.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  SearchPage({required this.id, super.key});
  String id;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String id = "1";
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjg0MTU1ODUzLCJleHAiOjE2ODQyNDIyNTN9.GErbzsc7CL7njcKQTVgq-S18kusdB7CwS6n4wpsTIv4";
  Widget _entryField(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        cursorColor: Colors.red,
        controller: controller,
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: Colors.white),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          labelText: hint,
          hintText: hint,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            isPassword ? Iconsax.key5 : Icons.supervised_user_circle,
            color: Colors.white,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 163, 163, 163), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 40, right: 70, left: 70),
              child: _entryField("search", controller: _emailController)),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<String>(
                  future: getUserById(token, "1"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else {
                      Map<String, dynamic> json =
                          jsonDecode(snapshot.data.toString());
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: ListView(
                            children: [
                              Text(
                                json["firstname"] ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "arial",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30),
                              )
                            ],
                          ));
                    }
                  },
                ),
              ],
            )));
  }
}
