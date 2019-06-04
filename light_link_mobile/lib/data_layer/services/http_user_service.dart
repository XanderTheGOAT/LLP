import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:http/http.dart';

class HttpUserService extends UserService {
  String _rootUrl;
  String get _profileUrl => _rootUrl + "profile/";
  String _token;

  HttpUserService(String host) {
    _rootUrl = "http://" + host + "/api/";
  }


  @override
  Future<void> addProfileToUser(String username, Profile profile) {
    // TODO: implement addProfileToUser
    return null;
  }

  @override
  Future<Profile> getActiveProfile(String username) {
    // TODO: implement getActiveProfile
    return null;
  }

  @override
  Future<Iterable<Profile>> getProfilesForUser(String username) {
    // TODO: implement getProfilesForUser
    return null;
  }

  @override
  Future<User> getUserById(String username) {
    // TODO: implement getUserById
    return null;
  }

  @override
  Future<void> linkComputerToUser(String username, String computerName) {
    // TODO: implement linkComputerToUser
    return null;
  }

  @override
  Future<void> removeProfileFromUser(String username, String profilename) {
    // TODO: implement removeProfileFromUser
    return null;
  }

  @override
  Future<void> updateActiveProfile(String username, Profile profile) {
    // TODO: implement updateActiveProfile
    return null;
  }

  @override
  Future<void> updateProfileConfigsWithComputer(String username) {
    // TODO: implement updateProfileConfigsWithComputer
    return null;
  }

  @override
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile) {
    return put(
      this._profileUrl + uname,
      headers: createAuthHeaders(),
      
          );
        }
      
  createAuthHeaders() {
    if(_token == null)
        throw new Exception();
    return { "Authorization" : this._token }; 
  }
}
