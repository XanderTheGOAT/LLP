import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';
import 'package:light_link_mobile/pages/view_profile_page.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;
  final Function(Profile) onDelete;
  final Function(String, Profile) onProfileChanged;
  final Function(Profile) setActive;
  String ogName;

  ProfileComponent(this.profile,
      [this.onDelete, this.onProfileChanged, this.setActive]) {
    this.ogName = this.profile.name;
  }

  void onRemoveClick() {
    this.onDelete(this.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      decoration: BoxDecoration(color: profile.getColor()),
      child: Column(
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.star,
                  color: colorIsDark() ? Colors.white : Colors.black,
                ),
                onPressed: () => this.setActive(profile),
              ),
              IconButton(
                tooltip: "Delete the profile",
                icon: Icon(
                  Icons.delete_forever,
                  color: colorIsDark() ? Colors.white : Colors.black,
                ),
                onPressed: onRemoveClick,
              ),
            ],
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
              RaisedButton.icon(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
                label: Text("View",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ViewProfilePage(this.profile)));
                },
              ),
              RaisedButton.icon(
                icon: Icon(
                  Icons.mode_edit,
                  color: Colors.white,
                ),
                label: Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blueGrey,
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ProfileEditingPage(
                              onProfileChanged,
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
