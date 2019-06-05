import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/components/profiles_component.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class MainPage extends StatelessWidget {
  final String username;
  final UserService service;
  final String password;
  MainPage(this.service, this.username, this.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _createTitle(),
      ),
      body: ProfilesComponent(
        this.service,
        this.username,
        this.password,
      ),
    );
  }

  _createTitle() {
    return Text(
      'Light Link',
      style: TextStyle(
        fontSize: 22,
        fontFamily: 'sans-serif',
        color: Colors.white,
      ),
    );
  }
}
