import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/services/random_user_service.dart';
import './pages/main_page.dart';
import 'data_layer/services/user_service.dart';

void main() {
  var service = RandomUserService.withSeededCache();
  var username = "gxldcptrick";
  var password = "Not A Secure Password";
  service
      .authenticate(username, password)
      .then((v) => service.getUserById(username))
      .then((u) => service.linkComputerToUser(username, "Mc Bitchin"))
      .then((v) => service.updateProfileConfigsWithComputer(username))
      .catchError((e) => debugPrint(e));
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
      ),
    );
  }
}
