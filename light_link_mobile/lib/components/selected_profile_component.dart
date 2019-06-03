import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';

class SelectedProfileComponent extends StatelessWidget {
  final Profile activeProfile;
  final String username;
  final UserService service;
  SelectedProfileComponent(this.username, this.activeProfile, this.service);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: this.activeProfile.getColor(),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(55),
              child: Center(
                child: Text(
                  activeProfile.name,
                  style: TextStyle(
                      color: colorIsDark() ? Colors.white : Colors.black),
                ),
              ),
            ),
            _createViewEditButton(context)
          ],
        ));
  }

  colorIsDark() {
    return activeProfile.getColor().computeLuminance() < .1;
  }

  _createViewEditButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 40,
      ),
      child: RaisedButton.icon(
          icon: Icon(
            Icons.mode_edit,
            color: Colors.white,
          ),
          label: Text(
            "View/Edit",
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
              )),
    );
  }
}
