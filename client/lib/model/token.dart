import 'package:flutter/material.dart';

class TokenStates extends ChangeNotifier {
  String _token = '';
  String get token {
    return _token;
  }

  set token(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  String _id = '';
  String get id {
    return _id;
  }

  set id(String newId) {
    _id = newId;
    notifyListeners();
  }
}
