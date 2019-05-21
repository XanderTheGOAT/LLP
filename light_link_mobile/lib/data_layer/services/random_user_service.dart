import 'dart:math';

import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class RandomUserService extends UserService {
  Map<String, User> cache;
  List<String> profileNames;
  Random rnJesus;
  User currentlyLoggedIn;

  RandomUserService() {
    rnJesus = Random();
    cache = Map<String, User>();
    profileNames = [
      "Milo is here",
      "Always put something in the list.",
      "What do you want ok",
      "Rude",
      "This is More For The Pool",
      "I need something more to add to it.",
      "Windows or Mac",
      "Flammability Requirments",
      "Kinky",
      "Discontinous",
      "Balls in Holes ;)",
      "Burger King Footlettuce.",
      "Factor The King",
      "Disapointed",
      "Foil this out mane",
      "Frijoles",
      "This is a really really really long thing in order to make this thing cool looking."
    ];
  }

  factory RandomUserService.withSeededCache() {
    var service = RandomUserService();
    service.cache["gxldcptrick"] = User.init("gxldcptrick", "", []);
    service.cache["alexthegoat"] = User.init("alexthegoat", "", []);
    return service;
  }

  @override
  Iterable<Profile> getProfilesForUser(String username) {
    if (cache[username].profiles.isEmpty) {
      cache[username].profiles =
          createProfiles().where((p) => p.name.length > 30).take(1000).toList();
    }
    return cache[username].profiles;
  }

  String generateColor() {
    int red = rnJesus.nextInt(256);
    int blue = rnJesus.nextInt(256);
    int green = rnJesus.nextInt(256);
    return "ff" +
        red.toRadixString(16) +
        blue.toRadixString(16) +
        green.toRadixString(16);
  }

  Iterable<Profile> createProfiles() sync* {
    while (true) {
      var color = generateColor();
      var profile = Profile.init(
        profileNames[rnJesus.nextInt(profileNames.length)],
        {
          "keyboard": color,
        },
      );
      yield profile;
    }
  }

  @override
  User getUserById(String username) {
    if (!cache.containsKey(username)) {
      cache[username] = new User.init(username, "", []);
    }
    currentlyLoggedIn = cache[username];
    return currentlyLoggedIn;
  }

  @override
  void removeProfileFromUser(String name) {
    currentlyLoggedIn.profiles.removeWhere((p) => p.name == name);
  }
}
