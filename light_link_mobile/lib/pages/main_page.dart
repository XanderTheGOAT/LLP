import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/components/profile_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class MainPage extends StatelessWidget {
  final List<Profile> profiles;
  final UserService service;
  MainPage(this.profiles, this.service);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          child: Text(
            'Light Link',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'sans-serif',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: profiles
            .map((c) => Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: ProfileComponent(c),
                ))
            .toList(),
      ),
    );
  }
}
