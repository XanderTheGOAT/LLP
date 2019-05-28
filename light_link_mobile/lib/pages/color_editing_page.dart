import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:light_link_mobile/components/custom_button_component.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';

class ColorEditingPage extends StatelessWidget {
  final Profile profile;
  final String config;
  ColorEditingPage(this.profile, this.config);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.config),
      ),
      body: ListView(children: [
        ColorPicker(
          onChanged: (c) =>
              this.profile.configurations[config] = c.value.toRadixString(16),
        ),
        CustomButton(
          "Save",
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ]),
    );
  }
}
