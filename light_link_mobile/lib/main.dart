import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/services/http_user_service.dart';
import 'package:light_link_mobile/data_layer/services/random_user_service.dart';
import './pages/main_page.dart';
import 'data_layer/services/user_service.dart';

var username = "gxldcptrick";
var password = "Not A Secure Password";

void main() {
  var service = HttpUserService(
    "69.27.22.253",
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
