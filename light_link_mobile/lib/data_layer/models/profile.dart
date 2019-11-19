import 'package:flutter/material.dart';

class Profile {
  static Set<String> _currentConfigs = [
    "keyboard",
    "mouse",
    "mousepad",
  ].toSet();
  static set currentConfigs(Set<String> newConfigs) {
    if (newConfigs != null) {
      _currentConfigs = newConfigs;
    }
  }

  static const String defaultColor = "ff00ffff";
  String name;
  bool isActive;
  Map<String, dynamic> configurations;
  DateTime _created;
  DateTime get created => _created;
  set created(DateTime value) {
    var now = DateTime.now();
    if (value != null && (value.isBefore(now) || value.isAtSameMomentAs(now))) {
      _created = value;
    }
  }

  Profile() : this.init("", new Map(), false, DateTime.now());
  Profile.init(this.name, this.configurations, this.isActive, this._created) {
    this.applyLatestConfigs();
  }
  Profile.copy(Profile copy)
      : this.init(copy.name, copy.configurations, copy.isActive, copy._created);

  Profile.fromJSON(Map<String, dynamic> json)
      : name = json["name"] as String,
        configurations = json["configurations"] as Map<String, dynamic>,
        isActive = json["isActive"] as bool,
        _created = DateTime.parse(json["created"]);

  Map<String, dynamic> toJson() => {
        'name': name,
        'configurations': configurations,
        'isActive': isActive,
        'created': _created.toIso8601String(),
      };

  Map<String, dynamic> getHexValuesWithoutAlpha() {
    var map = Map<String, dynamic>();
    var iterator = configurations.entries;
    iterator.forEach(
        (entry) => map[entry.key] = entry.value.toString().substring(2));
    return map;
  }

  Color getColor() {
    if (configurations.values.length > 0) {
      var map = Map<dynamic, int>();
      configurations.forEach((c, value) {
        if (map.containsKey(value)) {
          map[value]++;
        } else {
          map[value] = 1;
        }
      });
      var values = map.keys.toList();
      values.sort((first, second) => map[first].compareTo(map[second]) * -1);
      values.forEach((f) => () {
            print(f.toString());
          });
      return createColorMap(values.first);
    } else
      return Colors.black;
  }

  Color createColorMap(String first) {
    return Color(int.tryParse(first, radix: 16));
  }

  void applyLatestConfigs() {
    Profile._currentConfigs.forEach((c) {
      if (!this.configurations.containsKey(c)) {
        this.configurations[c] = defaultColor;
      }
    });
  }
}
