import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/pages/main_page.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';
import 'package:light_link_mobile/pages/view_profile_page.dart';

import 'custom_button_component.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;
  final MainPageState parent;
  final String ogName;

  const ProfileComponent(this.profile, this.parent, this.ogName);

  void onRemoveClick() {
    this.parent.removeProfile(this.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(color: profile.getColor()),
      child: Column(
        children: <Widget>[
          CustomButton(
            "Delete",
            onPressed: onRemoveClick,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              profile.name,
              style: TextStyle(
                color: colorIsDark() ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              CustomButton(
                "View",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ViewProfilePage(this.profile)));
                },
              ),
              CustomButton(
                "Edit",
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ProfileEditingPage(
                              this.parent.loggedIn,
                              (username, profile) => this.parent.updateProfile(
                                  username, profile, this.ogName),
                              this.profile,
                            ),
                      ),
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }

  colorIsDark() {
    return profile.getColor().computeLuminance() < .1;
  }
}
