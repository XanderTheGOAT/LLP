import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;
  final Function(Profile) _onDelete;
  final Function(String, Profile) _onProfileChanged;
  final Function(Profile) _onActiveCalled;

  ProfileComponent(this.profile,
      [this._onDelete, this._onProfileChanged, this._onActiveCalled]);

  void onRemoveClick() {
    this._onDelete(this.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      width: 250,
      decoration: BoxDecoration(color: profile.getColor()),
      child: Column(
        children: <Widget>[
          _createStarAndDeleteRow(),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 30,
              left: 30,
              right: 30,
            ),
            child: Center(
              child: Text(
                profile.name,
                style: TextStyle(
                  color: colorIsDark() ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          _createViewEditButton(context),
        ],
      ),
    );
  }

  colorIsDark() {
    return profile.getColor().computeLuminance() < .1;
  }

  _createViewEditButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
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
                      _onProfileChanged,
                      this.profile,
                    ),
              ),
            ),
      ),
    );
  }

  _createStarAndDeleteRow() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          tooltip: "Delete Profile",
          icon: Icon(
            Icons.delete_forever,
            color: colorIsDark() ? Colors.white : Colors.black,
          ),
          onPressed: onRemoveClick,
        ),
        IconButton(
          tooltip: "Set Profile as Active Profile",
          icon: Icon(
            Icons.star,
            color: colorIsDark() ? Colors.white : Colors.black,
          ),
          onPressed: () => this._onActiveCalled(profile),
        ),
      ],
    );
  }
}
