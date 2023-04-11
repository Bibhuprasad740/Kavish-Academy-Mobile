import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name, email, uid;
  bool isPlusMember;
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.isPlusMember,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'isPlusMember': isPlusMember,
      };
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      email: snap['email'],
      uid: snap['uid'],
      isPlusMember: snap['isPlusMember'],
    );
  }

  static UserModel fromMap(dynamic userMap) {
    return UserModel(
      name: userMap['name'],
      email: userMap['email'],
      uid: userMap['uid'],
      isPlusMember: userMap['isPlusMember'],
    );
  }
}
