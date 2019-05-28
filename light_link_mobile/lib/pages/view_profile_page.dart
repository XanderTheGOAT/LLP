import 'package:flutter/material.dart';
import 'package:light_link_mobile/components/color_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

class ViewProfilePage extends StatelessWidget {
  final Profile profile;
  ViewProfilePage(this.profile);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.profile.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Center(
                child: Text("Color Configs"),
              ),
            ),
            ...this.generateColorConfigRows()
          ],
        ),
      ),
    );
  }

  List<ColorComponent> generateColorConfigRows() {
    return this
        .profile
        .configurations
        .keys
        .map((k) => ColorComponent(this.profile.configurations[k], k))
        .toList();
  }
}
