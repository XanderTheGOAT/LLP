import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/services/random_user_service.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';
import './pages/main_page.dart';
import 'data_layer/services/user_service.dart';

void main() {
  var service = RandomUserService.withSeededCache();
  var user = "gxldcptrick";
  service.getUserById(user);
  runApp(MyApp(
    service,
    user,
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
      routes: {
        "addProfile": (context) => ProfileEditingPage(
              (oldname, profile) =>
                  this.service.addProfileToUser(username, profile),
            )
      },
    );
  }
}
