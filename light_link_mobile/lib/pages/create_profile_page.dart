import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_link_mobile/components/custom_button_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class CreateProfilePage extends StatefulWidget {
  final String username;
  final UserService service;

  CreateProfilePage(this.service, this.username);

  @override
  State<StatefulWidget> createState() {
    return CreateProfilePageState(this.service, this.username);
  }
}

class CreateProfilePageState extends State<CreateProfilePage> {
  UserService service;
  String username;
  Profile profile;
  CreateProfilePageState(this.service, this.username) {
    profile = Profile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: CustomButton(
                  "Finish",
                  onPressed: () {
                    this.service.addProfileToUser(this.username, this.profile);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
