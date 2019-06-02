import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';
import 'package:light_link_mobile/pages/view_profile_page.dart';

class SelectedProfileComponent extends StatelessWidget {
  final Profile activeProfile;
  final String username;
  final UserService service;
  SelectedProfileComponent(this.username, this.activeProfile, this.service);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [
              Colors.red,
              Colors.blue,
              Colors.pink,
              Colors.purple,
              Colors.yellow,
              Colors.orange
            ],
            stops: [
              0.1,
              0.3,
              0.5,
              0.7,
              .9,
              1,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Selected Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(55),
              child: Center(
                child: Text(
                  activeProfile.name,
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
                        builder: (ctx) => ViewProfilePage(this.activeProfile),
                      ),
                    );
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
                                (oldName, profile) {
                                  this.service.updateProfileForUser(
                                        this.username,
                                        oldName,
                                        profile,
                                      );
                                },
                                this.activeProfile,
                              ),
                        ),
                      ),
                ),
              ],
            )
          ],
        ));
  }
}
