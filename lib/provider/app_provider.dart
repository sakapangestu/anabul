import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AppProvider with ChangeNotifier{

  int activePage = 0;
  int get getActivePage { return activePage; }

  void setActivePage(dynamic data) async {
    activePage = data;

    notifyListeners();
  }

  void login(String email, String password) async {
    Uri url = Uri.parse("https://812b-182-253-183-126.ap.ngrok.io/api/auth/login");

    var response = await http.post(
        url,
        body: json.encode({
          "email" : email,
          "password" : password,
          "token" : true,
        })
    );
    print(json.decode(response.body));
    notifyListeners();
  }

}