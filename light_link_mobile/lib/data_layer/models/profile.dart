import 'package:flutter/material.dart';

class Profile {
  String name;
  bool isActive;
  Map<String, dynamic> configurations;
/////////////////////////////////////////////////////////////////////////////////////////

  Profile() : this.init("", new Map());
  Profile.init(this.name, this.configurations) {
    if (!this.configurations.containsKey("keyboard")) {
      configurations["keyboard"] = Colors.black.value.toRadixString(16);
    }
  }
  Profile.copy(Profile copy) : this.init(copy.name, copy.configurations);

  Profile.fromJSON(Map<String, dynamic> json)
      : name = json["name"] as String,
        configurations = json["configurations"] as Map<String, dynamic>,
        isActive = json["isActive"] as bool;

  Map<String, dynamic> toJson() =>
      {'name': name, 'configurations': configurations, 'isActive': isActive};

  Color getColor() {
    if (configurations.values.length > 0)
      return createColorMap(configurations.values.first);
    else
      return Colors.black;
  }

  Color createColorMap(String first) {
    return Color(int.tryParse(first, radix: 16));
  }
}
