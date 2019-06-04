import 'dart:convert';
import 'dart:io';

import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:http/http.dart' as http;

class HttpUserService extends UserService {
  String _rootUrl;
  String get _profileUrl => _rootUrl + "profile/";
  String get _userUrl => _rootUrl + "user/";
  String get _computerUrl => _rootUrl + "computer/";
  String _token;

  HttpUserService(String host) {
    _rootUrl = "http://" + host + "/api/";
  }

  @override
  Future<void> addProfileToUser(String username, Profile profile) {
    //TODO: Profile must be replaced with json represenation of profile
    http.post(this._profileUrl + username,
        headers: createAuthHeaders(), body: profile);
    return null;
  }

  @override
  Future<Profile> getActiveProfile(String username) {
    //TODO: Implement getActiveProfile
    var response = http.get(_profileUrl + "active/" + username,
        headers: createAuthHeaders());
    return null;
  }

  @override
  Future<Iterable<Profile>> getProfilesForUser(String username) {
    //TODO: Implement getProfilesForUser
    var response = http.get(_profileUrl + "active/" + username,
        headers: createAuthHeaders());
    return null;
  }

  @override
  Future<User> getUserById(String username) {
    //TODO: Implement getUserById
    var response =
        http.get(_userUrl + "active/" + username, headers: createAuthHeaders());
    return null;
  }

  @override
  Future<void> linkComputerToUser(String username, String computerName) {
    // TODO: implement linkComputerToUser
  }

  @override
  Future<void> removeProfileFromUser(
      String username, String profilename) async {
    var response = await http.delete(
        this._profileUrl + username + "/" + profilename,
        headers: createAuthHeaders());
    if (response.statusCode != 200) {
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }
  }

  @override
  Future<void> updateActiveProfile(String username, Profile profile) {
    return http.put(this._profileUrl + "activate/" + username,
        headers: createAuthHeaders(), body: json.encode(profile.toJson()));
  }

  @override
  Future<void> updateProfileConfigsWithComputer(String username) {
    //TODO: Implement updateProfileConfigsWithComputers
    return http.put(this._profileUrl + username, headers: createAuthHeaders());
  }

  @override
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile) {
    return http.put(this._profileUrl + uname, headers: createAuthHeaders());
  }

  createAuthHeaders() {
    if (_token == null) throw new Exception();
    return {"Authorization": this._token};
  }
}
