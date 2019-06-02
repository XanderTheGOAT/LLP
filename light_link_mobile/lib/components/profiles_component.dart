import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

import 'profile_component.dart';
import 'selected_profile_component.dart';

class ProfilesComponent extends StatefulWidget {
  final UserService service;
  final String username;
  ProfilesComponent(this.service, this.username);
  @override
  State<StatefulWidget> createState() {
    return ProfilesState(this.service, this.username);
  }
}

class ProfilesState extends State<ProfilesComponent> {
  UserService _service;
  List<Profile> _profiles;
  Profile _activeProfile;
  String _username;
  ProfilesState(this._service, this._username) {
    _updateState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _createSelectedDisplay(),
        ...this
            ._profiles
            .where((c) => c != _activeProfile)
            .map((profile) => _createProfileDisplays(profile, context))
            .toList(),
        _createAddButton()
      ],
    );
  }

  _updateState() {
    this.setState(() {
      _activeProfile = _service.getActiveProfile(_username);
      _profiles = _service
          .getProfilesForUser(_username)
          .where((p) => p != _activeProfile);
    });
  }

  _createDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 22),
      color: Colors.red,
      child: Icon(Icons.delete),
    );
  }

  _createAddButton() {
    return Padding(
      padding: EdgeInsets.only(
        top: 9,
        left: 15,
        right: 15,
        bottom: 9,
      ),
      child: RaisedButton.icon(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        color: Colors.blueGrey,
        onPressed: () => Navigator.pushNamed(context, "addProfile"),
        label: Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _createProfileDisplays(Profile profileData, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 9,
      ),
      child: Dismissible(
        background: _createDismissibleBackground(),
        key: ObjectKey(profileData.name),
        onDismissed: _createDismissibleCallback(profileData, context),
        child: _createProfileDisplay(profileData),
      ),
    );
  }

  _createSelectedDisplay() {
    var activeProfile = _service.getActiveProfile(this._username);
    return Padding(
      padding: EdgeInsets.only(
        top: 9,
        left: 5,
        right: 5,
      ),
      child: SelectedProfileComponent(
        this._username,
        activeProfile,
        this._service,
      ),
    );
  }

  _createProfileDisplay(Profile profileData) {
    return ProfileComponent(
      profileData,
      (p) {
        _service.removeProfileFromUser(
          this._username,
          p.name,
        );
        this._updateState();
      },
      (oldName, p) {
        _service.updateProfileForUser(
          this._username,
          oldName,
          p,
        );
        this._updateState();
      },
      (p) {
        _service.updateActiveProfile(
          this._username,
          p,
        );
        this._updateState();
      },
    );
  }

  _createDismissibleCallback(Profile profileData, BuildContext context) {
    return (DismissDirection direction) {
      if (direction == DismissDirection.startToEnd) {
        _removeProfile(profileData, context);
      } else if (direction == DismissDirection.endToStart) {
        _activateProfile(profileData);
      }
    };
  }

  void _removeProfile(Profile profileData, BuildContext context) {
    this._service.removeProfileFromUser(
          this._username,
          profileData.name,
        );
    _updateState();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Profile Deleted!!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            this._service.addProfileToUser(
                  this._username,
                  profileData,
                );
          },
        ),
      ),
    );
  }

  void _activateProfile(Profile profileData) {
    this._service.updateActiveProfile(_username, profileData);
    _updateState();
  }
}
