import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/services/http_user_service.dart';
import 'package:light_link_mobile/data_layer/services/random_user_service.dart';
import './pages/main_page.dart';
import 'package:http/http.dart' as http;
import 'data_layer/services/user_service.dart';

var username = "user";
var password = "pass";

void main() {
  var service = HttpUserService(
    "172.17.77.241:44332",
    false,
  ); // RandomUserService.withSeededCache();
  runApp(MyApp(
    service,
    username,
  ));
}

class MyApp extends StatelessWidget {
  final UserService service;
  final String username;
  MyApp(this.service, this.username);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Light Link',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainPage(
        service,
        username,
        password,
      ),
    );
  }
}
