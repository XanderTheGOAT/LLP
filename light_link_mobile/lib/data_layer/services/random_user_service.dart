import 'dart:math';

import 'package:light_link_mobile/data_layer/models/computer.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';

class RandomUserService extends UserService {
  Map<String, User> cache;
  List<String> profileNames;
  List<Computer> puters;
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
    puters = [
      Computer.init("Mc Bitchin", ["keyboard", "mouse", "mousepad"], null)
    ];
  }

  factory RandomUserService.withSeededCache() {
    var service = RandomUserService();
    service.getUserById("gxldcptrick");
    service.getUserById("alexTheGoat");
    return service;
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
        Map<String, dynamic>(),
        false,
        DateTime.now().subtract(
          Duration(
            days: rnJesus.nextInt(100),
          ),
        ),
      );
      yield profile;
    }
  }

  void reRollColors(Profile p) {
    p.configurations.keys.forEach((k) => p.configurations[k] = generateColor());
  }

  @override
  Future<void> addProfileToUser(String username, Profile profile) {
    return Future(() {
      cache[username].profiles.add(profile);
    });
  }

  @override
  Future<Profile> getActiveProfile(String username) {
    return Future(() => cache[username].profiles.firstWhere((p) => p.isActive));
  }

  @override
  Future<Iterable<Profile>> getProfilesForUser(String username) {
    return Future(() => cache[username].profiles);
  }

  @override
  Future<User> getUserById(String username) {
    return Future(() {
      if (!cache.containsKey(username)) {
        var profiles = this.createProfiles().take(10).toList();
        profiles.first.isActive = true;
        cache[username] = User.init(username, "password", profiles);
      }

      return cache[username];
    });
  }

  @override
  Future<void> linkComputerToUser(String username, String computerName) {
    return Future(() => this
        .puters
        .where((c) => c.name == computerName)
        .forEach((c) => c.userName = username));
  }

  @override
  Future<void> removeProfileFromUser(String username, String profilename) {
    return Future(() => this
        .cache[username]
        .profiles
        .removeWhere((p) => p.name == profilename));
  }

  @override
  Future<void> updateActiveProfile(String username, Profile profile) {
    return Future(() {
      cache[username].profiles.forEach((p) => p.isActive = false);
      cache[username].profiles.firstWhere((p) => p == profile).isActive = true;
    });
  }

  @override
  Future<void> updateProfileConfigsWithComputer(String username) {
    return Future(() {
      var props = Set<String>();
      puters
          .where((c) => c.userName == username)
          .forEach((c) => c.connectedDevices.forEach(props.add));
      Profile.currentConfigs = props;
      cache[username].profiles.forEach((p) {
        p.applyLatestConfigs();
        reRollColors(p);
      });
    });
  }

  @override
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile) {
    return Future(() {});
  }
}
