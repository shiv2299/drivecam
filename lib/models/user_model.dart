import 'dart:convert';

class User {
  User({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  UserData data;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        data: json["status"] ? UserData.fromJson(json["data"]) : null,
      );
}

class UserData {
  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.bloodGroup,
    this.kinName,
    this.unitCode,
    this.role,
    this.username,
    this.password,
    this.isActive,
    this.createdAt,
  });

  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic bloodGroup;
  dynamic kinName;
  dynamic unitCode;
  dynamic role;
  dynamic username;
  dynamic password;
  dynamic isActive;
  DateTime createdAt;

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bloodGroup: json["blood_group"],
        kinName: json["kin_name"],
        unitCode: json["unit_code"],
        role: json["role"],
        username: json["username"],
        password: json["password"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
