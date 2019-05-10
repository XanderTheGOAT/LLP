import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/services/random_user_service.dart';
import './pages/main_page.dart';
import 'data_layer/services/user_service.dart';

void main() {
  runApp(MyApp(
    RandomUserService.withSeededCache(),
    "gxldcptrick",
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
        primarySwatch: Colors.deepPurple,
      ),
      home: MainPage(service.getProfilesForUser(username)),
    );
  }
}
