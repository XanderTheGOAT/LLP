import './profile.dart';

class User {
  String userName;
  String password;
  List<Profile> profiles;
  User(this.userName, this.password, this.profiles);
  User.fromJSON(Map<String, dynamic> json)
      : userName = json["userName"],
        password = json["password"] {
    var profilesJSON = json["profiles"] as List<Map<String, dynamic>>;
    profiles = profilesJSON.map((json) => Profile.fromJSON(json));
  }

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'profiles': profiles.map((p) => p.toJson()).toList()
      };
}
