import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

class ProfileComponent extends StatelessWidget {
  final Profile profile;

  const ProfileComponent(this.profile);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(profile.name),
    );
  }
}
