class User {
  User({
    this.id,
    this.faceData,
    this.firstName,
    this.lastName,
    this.bloodGroup,
    this.kinName,
    this.username,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String faceData;
  String firstName;
  String lastName;
  String bloodGroup;
  String kinName;
  String username;
  String password;
  String createdAt;
  String updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        faceData: json["face_data"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        bloodGroup: json["blood_group"],
        kinName: json["kin_name"],
        username: json["username"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "face_data": faceData,
        "first_name": firstName,
        "last_name": lastName,
        "blood_group": bloodGroup,
        "kin_name": kinName,
        "username": username,
        "password": password,
      };
}
