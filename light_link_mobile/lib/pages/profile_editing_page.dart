import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_link_mobile/components/color_component.dart';
import 'package:light_link_mobile/components/custom_button_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

import 'color_editing_page.dart';

class ProfileEditingPage extends StatefulWidget {
  final Function(String, Profile) callback;
  final Profile profile;
  ProfileEditingPage(this.callback, [this.profile]);
  @override
  State<StatefulWidget> createState() {
    return ProfileEditingPageState(
      this.callback,
      this.profile,
    );
  }
}

class ProfileEditingPageState extends State<ProfileEditingPage> {
  Profile profile;
  TextEditingController _controller;
  final Function(String, Profile) callback;
  String oldName;
  ProfileEditingPageState(this.callback, [this.profile]) {
    profile = profile == null ? Profile() : Profile.copy(profile);
    _controller = TextEditingController(text: profile.name);
    oldName = profile.name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  onSubmitted: (c) {
                    this.profile.name = c;
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: "Name e.g. Best Profile",
                  ),
                ),
              ),
              ...this._createColorFields(context),
              Padding(
                padding: EdgeInsets.all(20),
                child: CustomButton(
                  "Finish",
                  onPressed: () {
                    callback(this.oldName, this.profile);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> _createColorFields(context) {
    return this
        .profile
        .configurations
        .keys
        .map(
          (k) => FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => ColorEditingPage(
                          profile,
                          k,
                          this.profile.configurations[k],
                        )),
              );
            },
            child: ColorComponent(
              this.profile.configurations[k],
              k,
            ),
          ),
        )
        .toList();
  }
}
