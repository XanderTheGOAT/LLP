class Computer {
  String name;
  List<String> connectedDevices;
  String userName;

  Computer(this.name, this.connectedDevices, this.userName);
  Computer.fromJSON(Map<String, dynamic> json)
      : name = json["name"],
        userName = json["userName"],
        connectedDevices = json["connectedDevices"];
  Map<String, dynamic> toJson() => {
        'name': name,
        'userName': userName,
        'connectedDevices': connectedDevices
      };
}
