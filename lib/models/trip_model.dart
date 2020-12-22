import 'dart:convert';

class Trip {
  Trip({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  TripData data;

  factory Trip.fromRawJson(String str) => Trip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        status: json["status"],
        message: json["message"],
        data: json["status"] ? TripData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class TripData {
  TripData({
    this.id,
    this.userId,
    this.from,
    this.to,
    this.currentStatus,
    this.isActive,
    this.createdAt,
  });

  String id;
  String userId;
  String from;
  String to;
  String currentStatus;
  String isActive;
  DateTime createdAt;

  factory TripData.fromRawJson(String str) =>
      TripData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
        id: json["id"],
        userId: json["user_id"],
        from: json["from"],
        to: json["to"],
        currentStatus: json["current_status"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "from": from,
        "to": to,
        "current_status": currentStatus,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
      };
}
