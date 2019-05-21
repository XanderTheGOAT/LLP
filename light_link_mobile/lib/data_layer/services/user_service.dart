import '../models/user.dart';
import '../models/profile.dart';

abstract class UserService {
  User getUserById(String username);
  Iterable<Profile> getProfilesForUser(String username);
  void removeProfileFromUser(String name);
}
