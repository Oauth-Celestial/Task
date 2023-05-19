import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String? id;
  String? userName;
  String? email;
  String? profileUrl;
  Timestamp? joinedDate;

  AppUser(
      {this.id, this.userName, this.email, this.joinedDate, this.profileUrl});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
        id: (json["id"] ?? "") as String,
        userName: (json["userName"] ?? "") as String,
        email: (json["email"] ?? "") as String,
        profileUrl: json["profileUrl"],
        joinedDate: json["joinedOn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userName": this.userName,
      "email": this.email,
      "profileUrl": this.profileUrl,
      "joinedOn": this.joinedDate,
    };
  }
}
