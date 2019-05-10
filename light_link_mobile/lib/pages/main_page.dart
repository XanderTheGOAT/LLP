import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/components/profile_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

class MainPage extends StatelessWidget {
  final List<Profile> profiles;
  MainPage(this.profiles);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          child: Text(
            'Light Link',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'serif',
              color: Colors.amber,
            ),
          ),
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.max,
        children: profiles
            .map((c) => Padding(
                  padding: EdgeInsets.all(12),
                  child: ProfileComponent(c),
                ))
            .toList(),
      ),
    );
  }
}
