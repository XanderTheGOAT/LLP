import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:light_link_mobile/data_layer/models/profile.dart';
import 'package:light_link_mobile/data_layer/models/user.dart';
import 'package:light_link_mobile/data_layer/services/user_service.dart';
import 'package:http/http.dart';

class HttpUserService extends UserService {
  String _rootUrl;
  String get _profileUrl => _rootUrl + "profile/";
  HttpUserService(String host) {
    _rootUrl = "http://" + host + "/api/";
  }
}
