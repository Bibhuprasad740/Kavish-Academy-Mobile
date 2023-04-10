import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name, email;
  bool isPlusMember;
  UserModel({
    required this.name,
    required this.email,
    required this.isPlusMember,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'isPlusMember': isPlusMember,
      };
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      email: snap['email'],
      isPlusMember: snap['isPlusMember'],
    );
  }
}
