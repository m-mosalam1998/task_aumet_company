import 'dart:convert';

import 'package:task_company/model/university.dart';

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String? imageUrl;
  final List<University>? unversitys;
  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.unversitys,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
        'unversitys': unversitys,
      };
  factory User.fromJson(Map<String, dynamic> json) {
    List arrayJson = jsonDecode(json['unversitys']);

    return User(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      unversitys: List.generate(
        arrayJson.length,
        (index) => University.fromJson(
          (arrayJson.elementAt(index)),
        ),
      ),
    );
  }
}
