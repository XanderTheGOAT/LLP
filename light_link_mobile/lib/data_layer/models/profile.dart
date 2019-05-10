class Profile {
  String name;
  Map<String, dynamic> configurations;
  Profile(this.name, this.configurations);
  Profile.fromJSON(Map<String, dynamic> json)
      : name = json["name"] as String,
        configurations = json["configurations"] as Map<String, dynamic>;
  Map<String, dynamic> toJson() =>
      {'name': name, 'configurations': configurations};
}
