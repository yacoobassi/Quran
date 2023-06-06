import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  String image;
  String date;
  String uid;
  String token;
  bool student;
  String institute;
  String regiment;
  String password;
  String inistituteName;

  UserModel(
      {this.email,
      this.name,
      this.image,
      this.date,
      this.uid,
      this.token,
      this.student,
      this.institute,
      this.regiment});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        email: snapshot['email'],
        name: snapshot['name'],
        image: snapshot['image'],
        date: snapshot['date'].toString(),
        uid: snapshot['uid'],
        token: snapshot['token'],
        student: snapshot['student'],
        institute: snapshot['institute'],
        regiment: snapshot['regiment']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'image': image,
        "date": date,
        'uid': uid,
        "token": token,
        "student": student,
        "institute": institute,
        "regiment": regiment
      };
}
