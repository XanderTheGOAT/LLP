import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/components/custom_button_component.dart';
import 'package:light_link_mobile/components/profile_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class MainPage extends StatefulWidget {
  final String loggedIn;
  final UserService service;
  MainPage(this.loggedIn, this.service);

  @override
  State<StatefulWidget> createState() {
    return MainPageState(this.loggedIn, this.service);
  }
}

class MainPageState extends State<MainPage> {
  final String loggedIn;
  List<Profile> profiles;
  UserService service;
  MainPageState(this.loggedIn, this.service) {
    this.profiles = this.service.getProfilesForUser(loggedIn);
  }

  void onAddProfilePressed() {
    //Do Nothing for now.
    debugPrint("Add Profile Pressed");
  }

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
        children: [
          ...this
              .profiles
              .map((c) => Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: ProfileComponent(
                      c,
                      this,
                      c.name,
                    ),
                  ))
              .toList(),
          new Padding(
              padding: EdgeInsets.only(
                top: 9,
                left: 15,
                right: 15,
                bottom: 9,
              ),
              child: CustomButton(
                "Add Profile",
                onPressed: () => Navigator.pushNamed(context, "addProfile"),
                width: 50,
                height: 100,
                fontSize: 22,
              ))
        ],
      ),
    );
  }

  void removeProfile(Profile c) {
    this.service.removeProfileFromUser(loggedIn, c.name);
    this.setState(() => profiles = service.getProfilesForUser(loggedIn));
  }

  updateProfile(String uname, Profile profile, String ogName) {
    this.service.updateProfileForUser(uname, ogName, profile);
  }
}
