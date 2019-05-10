import 'dart:math';

import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class RandomUserService extends UserService {
  Map<String, User> cache;
  List<String> profileNames;
  Random rnJesus;

  RandomUserService() {
    rnJesus = Random();
    cache = Map<String, User>();
    profileNames = [
      "Milo is here",
      "Always put something in the list.",
      "What do you want ok",
      "rude"
    ];
  }

  factory RandomUserService.withSeededCache() {
    var service = RandomUserService();
    service.cache["gxldcptrick"] = User("gxldcptrick", "", []);
    service.cache["alexthegoat"] = User("alexthegoat", "", []);
    return service;
  }

  @override
  Iterable<Profile> getProfilesForUser(String username) {
    if (cache[username].profiles.isEmpty) {
      cache[username].profiles = createProfiles().take(10).toList();
    }
    return cache[username].profiles;
  }

  Iterable<Profile> createProfiles() sync* {
    while (true) {
      var profile =
          Profile(profileNames[rnJesus.nextInt(profileNames.length)], {});
      yield profile;
    }
  }

  @override
  User getUserById(String username) {
    if (!cache.containsKey(username)) {
      cache[username] = new User(username, "", []);
    }
    return cache[username];
  }
}
