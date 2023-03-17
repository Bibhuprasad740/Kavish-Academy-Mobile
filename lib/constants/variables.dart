import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Variables {
  static var auth = FirebaseAuth.instance;
  static var firestore = FirebaseFirestore.instance;
}
