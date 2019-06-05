import 'dart:async';

import '../models/user.dart';
import '../models/profile.dart';

abstract class UserService {
  Future<User> getUserById(String username);
  Future<Iterable<Profile>> getProfilesForUser(String username);
  Future<void> removeProfileFromUser(String username, String profilename);
  Future<void> addProfileToUser(String username, Profile profile);
  Future<Profile> getActiveProfile(String username);
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile);
  Future<void> updateActiveProfile(String username, Profile profile);
  Future<void> updateProfileConfigsWithComputer(String username);
  Future<void> linkComputerToUser(String username, String computerName);
  Future<void> authenticate(String username, String password);
}
