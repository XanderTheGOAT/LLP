import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

import 'custome_button_component.dart';

class AddProfileComponent extends StatefulWidget {
  String username;
  UserService service;

  AddProfileComponent(this.service, this.username);

  @override
  State<StatefulWidget> createState() {
    return AddProfileComponentState(this.service, this.username);
  }
}

class AddProfileComponentState extends State<AddProfileComponent> {
  UserService service;
  String username;
  Profile profile;
  AddProfileComponentState(this.service, this.username) {
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
