import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name, email;
  UserModel({
    required this.name,
    required this.email,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      email: snap['email'],
    );
  }
}
