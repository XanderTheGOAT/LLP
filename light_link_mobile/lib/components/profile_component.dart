import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

import 'custome_button_component.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;
  const ProfileComponent(this.profile);

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(color: profile.getColor()),
      child: Column(
        children: <Widget>[
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
                onPressed: doNothing,
              ),
              CustomButton(
                "Edit",
                onPressed: doNothing,
              )
            ],
          ),
        ],
      ),
    );
  }

  colorIsDark() {
    return profile.getColor().computeLuminance() < .2;
  }
}
