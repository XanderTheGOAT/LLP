import 'dart:async';
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
  Future<Iterable<Profile>> getProfilesForUser(String username) async {
    //TODO: Implement getProfilesForUser
    var response = await http.get(_profileUrl + "active/" + username,
        headers: createAuthHeaders());

    var completer = new Completer<Iterable<Profile>>();
    var iterable = new List<Profile>.from(json.decode(response.body));
    completer.complete(iterable);

    return completer.future;
  }

  @override
  Future<User> getUserById(String username) async {
    //TODO: Implement getUserById
    var response = await http.get(_profileUrl + "active/" + username,
        headers: createAuthHeaders());
    var completer = new Completer<User>();
    var user = User.fromJSON(json.decode(response.body));
    completer.complete(user);

    return completer.future;
  }

  @override
  Future<void> linkComputerToUser(String username, String computerName) {}

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
  Future<void> updateActiveProfile(String username, Profile profile) async {
    var response = await http.put(this._profileUrl + "activate/" + username,
        headers: createAuthHeaders(), body: json.encode(profile.toJson()));
    if (response.statusCode != 200) {
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }
  }

  @override
  Future<void> updateProfileConfigsWithComputer(String username) async {
    var response = await http.get(
      this._computerUrl + username,
      headers: createAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }
  }

  @override
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile) {
    return http.put(this._profileUrl + uname, headers: createAuthHeaders());
  }

  @override
  Future<void> authenticate(String username, String password) async {
    var response = await http.post(
      this._userUrl,
      body: {"username": username, "password": password},
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        throw HttpException("The credentials were invalid.");
      }
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }

    var responseJson = json.decode(response.body);
    this._token = responseJson["token"];
  }

  createAuthHeaders() {
    if (_token == null)
      throw new Exception("Cannot make headers with null token.");
    return {"Authorization": this._token};
  }
}
