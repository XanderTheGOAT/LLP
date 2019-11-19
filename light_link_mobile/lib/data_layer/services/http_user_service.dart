import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:light_link_mobile/data_layer/models/computer.dart';
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

  HttpUserService(String host, bool isHttps) {
    _rootUrl = "http" + (isHttps ? "s" : "") + "://" + host + "/api/";
  }

  @override
  Future<void> addProfileToUser(String username, Profile profile) async {
    var headers = createAuthHeaders();
    headers["content-type"] = "application/json";
    var response = await http.post(
      this._profileUrl + username,
      headers: headers,
      body: json.encode(
        profile.toJson(),
      ),
    );
    print("Name: " + profile.name);
    if (response.statusCode != 200) {
      return Future.error(
        HttpException(
          "Server Responded : " +
              response.statusCode.toString() +
              "but expected: 200",
        ),
      );
    }
  }

  @override
  Future<Profile> getActiveProfile(String username) async {
    var response = await http.get(
      _profileUrl + "active/" + username,
      headers: createAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }
    var bodyJson = json.decode(response.body);
    print(bodyJson);
    return Profile.fromJSON(bodyJson);
  }

  @override
  Future<Iterable<Profile>> getProfilesForUser(String username) async {
    var response = await http.get(
      _profileUrl + username,
      headers: createAuthHeaders(),
    );
    if (response.statusCode != 200) {
      return Future.error(HttpException("Server Responded: " +
          response.statusCode.toString() +
          " but expected: 200"));
    }
    var iterable = List.from(
      json.decode(response.body),
    ).map((c) => Profile.fromJSON(c));
    iterable.forEach((f) => () {
          print(f);
        });
    return iterable;
  }

  @override
  Future<User> getUserById(String username) async {
    var response = await http.get(
      _profileUrl + username,
      headers: createAuthHeaders(),
    );
    if (response.statusCode != 200) {
      throw HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200");
    }
    var user = User.fromJSON(json.decode(response.body));
    return user;
  }

  @override
  Future<void> linkComputerToUser(String username, String computerName) async {
    var response = await http.get(
      _computerUrl,
      headers: createAuthHeaders(),
    );
    if (response.statusCode != 200) {
      return Future.error(HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200"));
    }
    var computer = List.of(json.decode(response.body))
        .map((c) => Computer.fromJSON(c))
        .singleWhere((c) => c.name == computerName);
    computer.userName = username;
    var headers = createAuthHeaders();
    headers["content-type"] = "application/json";
    var secondResponse = await http.put(
      _computerUrl + computerName,
      headers: headers,
      body: json.encode(computer.toJson()),
    );
    print("Link to computer");
    if (secondResponse.statusCode != 200) {
      return Future.error(HttpException(
        "Server Responded :" +
            secondResponse.statusCode.toString() +
            " but expected: 200",
      ));
    }
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
          " but expected: 200");
    }
  }

  @override
  Future<void> updateActiveProfile(String username, Profile profile) async {
    var headers = createAuthHeaders();
    headers["content-type"] = "application/json";
    var response = await http.post(
      this._profileUrl + "activate/" + username,
      headers: headers,
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode != 200) {
      return Future.error(HttpException("Server Responded: " +
          response.statusCode.toString() +
          " but expected: 200"));
    }
  }

  @override
  Future<void> updateProfileConfigsWithComputer(String username) async {
    var headers = createAuthHeaders();
    headers["content-type"] = "application/json";
    var response = await http.get(
      this._computerUrl + username,
      headers: headers,
    );
    if (response.statusCode != 200) {
      return Future.error(Exception("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200"));
    }
    var setup = Set<String>();
    List.of(json.decode(response.body))
        .map((c) => Computer.fromJSON(c).connectedDevices)
        .expand((a) => a)
        .forEach(setup.add);
    Profile.currentConfigs = setup;
  }

  @override
  Future<void> updateProfileForUser(
      String uname, String ogName, Profile profile) async {
    print(profile.toJson());
    var headers = createAuthHeaders();
    headers["content-type"] = "application/json";
    var response = await http.put(
      this._profileUrl + uname + "/" + ogName,
      headers: headers,
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode != 200) {
      return Future.error(HttpException("Server Responded : " +
          response.statusCode.toString() +
          "but expected: 200"));
    }
  }

  @override
  Future<void> authenticate(String username, String password) async {
    var response = await http.post(
      this._userUrl + "authenticate",
      headers: {"content-type": "application/json"},
      body: json.encode({"username": username, "password": password}),
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        return Future.error("E");
      }
      return Future.error(HttpException("Server Responded : " +
          response.statusCode.toString() +
          " but expected: 200"));
    }

    var responseJson = json.decode(response.body);
    this._token = responseJson["token"];
    print("Fetched Token");
    debugPrint("Fetched Token");
  }

  createAuthHeaders() {
    if (_token == null)
      throw new Exception("Cannot make headers with null token.");
    return {"Authorization": "Bearer " + this._token};
  }
}
