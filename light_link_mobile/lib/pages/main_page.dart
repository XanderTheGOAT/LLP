import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/components/profiles_component.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class MainPage extends StatelessWidget {
  final String username;
  final UserService service;
  MainPage(this.service, this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _createTitle(),
      ),
      body: ProfilesComponent(this.service, this.username),
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
