import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:light_link_mobile/pages/profile_editing_page.dart';

import 'profile_component.dart';
import 'selected_profile_component.dart';

class ProfilesComponent extends StatefulWidget {
  final UserService service;
  final String username;
  final String password;
  ProfilesComponent(this.service, this.username, this.password);
  @override
  State<StatefulWidget> createState() {
    return ProfilesState(
      this.service,
      this.username,
      this.password,
    );
  }
}

class ProfilesState extends State<ProfilesComponent> {
  UserService _service;
  List<Profile> _profiles;
  Profile _activeProfile;
  String _username;
  final String _password;
  ProfilesState(this._service, this._username, this._password) {
    _service
        .authenticate(_username, _password)
        .then((c) => debugPrint("Logged In"))
        .then((c) =>
            _service.linkComputerToUser(_username, "THE-GOATS-PC:CE2F71C8E687"))
        .then((c) => _fetchProfiles())
        .catchError((e) => setState(() {
              debugPrint(e.toString());
              _activeProfile.name = "Failed To Fetch";
            }));
    _profiles = [];
    _activeProfile = Profile.init(
        "Loading...", Map<String, dynamic>(), true, DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _createSelectedDisplay(),
        ...this
            ._profiles
            .where((c) => c != _activeProfile)
            .map((profile) => _createProfileDisplays(profile, context))
            .toList(),
        _createAddButton(context)
      ],
    );
  }

  _updateState() {
    _fetchProfiles();
  }

  _createDismissibleBackground() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.yellow],
          stops: [.1, 1],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.delete,
          ),
          Icon(
            Icons.star,
          ),
        ],
      ),
    );
  }

  _createAddButton(BuildContext context) {
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
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ProfileEditingPage(
                      (oldname, profile) {
                        this
                            ._service
                            .addProfileToUser(_username, profile)
                            .then((v) => _updateState());
                      },
                    ),
              ),
            ),
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
    return Padding(
      padding: EdgeInsets.only(
        top: 9,
        left: 5,
        right: 5,
      ),
      child: SelectedProfileComponent(
        this._username,
        this._activeProfile,
        this._service,
      ),
    );
  }

  _createProfileDisplay(Profile profileData) {
    return ProfileComponent(
      profileData,
      (p) {
        setState(() => _profiles.remove(p));
        _service
            .removeProfileFromUser(
              this._username,
              p.name,
            )
            .then((c) => this._updateState());
      },
      (oldName, p) {
        setState(() {});
        _service
            .updateProfileForUser(
              this._username,
              oldName,
              p,
            )
            .then((c) => this._updateState());
      },
      _activateProfile,
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
    setState(() {
      _profiles.remove(profileData);
    });
    this
        ._service
        .removeProfileFromUser(
          this._username,
          profileData.name,
        )
        .then((c) => _updateState());
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Profile Deleted!!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _profiles.add(profileData);
            });
            this
                ._service
                .addProfileToUser(
                  this._username,
                  profileData,
                )
                .then((c) {
              _updateState();
            });
          },
        ),
      ),
    );
  }

  void _activateProfile(Profile profileData) {
    setState(() {
      _profiles.add(_activeProfile);
      _activeProfile = profileData;
      _profiles = _profiles.where((p) => p != profileData).toList();
    });

    this._service.updateActiveProfile(_username, profileData).then((c) {
      _updateState();
    });
  }

  void _fetchProfiles() {
    _service.getProfilesForUser(_username).then((c) => this.setState(() {
          _profiles = c.toList();
          if (_profiles.length > 0) {
            _activeProfile = _profiles.firstWhere((p) => p.isActive);
            _profiles.sort((p1, p2) => p1.created.compareTo(p2.created));
          } else {
            _activeProfile = Profile.init("No Profiles Yet Add One",
                Map<String, dynamic>(), false, DateTime.now());
          }
        }));
  }
}
