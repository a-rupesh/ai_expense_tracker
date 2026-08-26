<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<String> getUserName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (!doc.exists) {
      return "User";
    }

    return doc.data()?["name"] ?? "User";
  }
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<String> getUserName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (!doc.exists) {
      return "User";
    }

    return doc.data()?["name"] ?? "User";
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}