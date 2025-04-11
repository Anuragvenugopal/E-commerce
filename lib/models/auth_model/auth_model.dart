// To parse this JSON data, do
//
//     final authmodel = authmodelFromJson(jsonString);

import 'dart:convert';

Authmodel authmodelFromJson(String str) => Authmodel.fromJson(json.decode(str));

String authmodelToJson(Authmodel data) => json.encode(data.toJson());

class Authmodel {
  final String? response;
  final Logindetails? logindetails;

  Authmodel({
    this.response,
    this.logindetails,
  });

  factory Authmodel.fromJson(Map<String, dynamic> json) => Authmodel(
    response: json["response"],
    logindetails: json["logindetails"] == null ? null : Logindetails.fromJson(json["logindetails"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "logindetails": logindetails?.toJson(),
  };
}

class Logindetails {
  final String? token;
  final String? username;
  final String? id;
  final String? type;
  final String? status;
  final DateTime? tokenExpiry;
  final DateTime? expiryTime;

  Logindetails({
    this.token,
    this.username,
    this.id,
    this.type,
    this.status,
    this.tokenExpiry,
    this.expiryTime,
  });

  factory Logindetails.fromJson(Map<String, dynamic> json) => Logindetails(
    token: json["token"],
    username: json["username"],
    id: json["id"],
    type: json["type"],
    status: json["status"],
    tokenExpiry: json["token_expiry"] == null ? null : DateTime.parse(json["token_expiry"]),
    expiryTime: json["expiry_time"] == null ? null : DateTime.parse(json["expiry_time"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "username": username,
    "id": id,
    "type": type,
    "status": status,
    "token_expiry": "${tokenExpiry!.year.toString().padLeft(4, '0')}-${tokenExpiry!.month.toString().padLeft(2, '0')}-${tokenExpiry!.day.toString().padLeft(2, '0')}",
    "expiry_time": expiryTime?.toIso8601String(),
  };
}
