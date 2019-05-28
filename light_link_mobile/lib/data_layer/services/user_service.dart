import '../models/user.dart';
import '../models/profile.dart';

abstract class UserService {
  User getUserById(String username);
  Iterable<Profile> getProfilesForUser(String username);
  void removeProfileFromUser(String username, String profilename);
  void addProfileToUser(String username, Profile profile);

  void updateProfileForUser(String uname, String ogName, Profile profile);
}
