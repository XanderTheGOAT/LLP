import 'package:flutter/material.dart';

class Profile {
  String name;
  bool isActive;
  Map<String, dynamic> configurations;
  DateTime _created;
  DateTime get created => _created;
  set created(DateTime value) {
    if (value != null && !value.isAfter(DateTime.now())) {
      _created = value;
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////

  Profile() : this.init("", new Map(), false, DateTime.now());
  Profile.init(this.name, this.configurations, this.isActive, this._created) {
    if (!this.configurations.containsKey("keyboard")) {
      configurations["keyboard"] = Colors.black.value.toRadixString(16);
    }
  }
  Profile.copy(Profile copy)
      : this.init(copy.name, copy.configurations, copy.isActive, copy._created);

  Profile.fromJSON(Map<String, dynamic> json)
      : name = json["name"] as String,
        configurations = json["configurations"] as Map<String, dynamic>,
        isActive = json["isActive"] as bool,
        _created = json["created"] as DateTime;

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
