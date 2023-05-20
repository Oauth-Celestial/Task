import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagment/Model/UserModel.dart';
import 'package:taskmanagment/main.dart';

class HomeScreenController extends DisposableProvider {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  Stream<QuerySnapshot>? userTaskStream = firestore
      .collection("Users")
      .doc(auth.currentUser!.uid)
      .collection("Task")
      .snapshots();

  @override
  void disposeValues() {
    userTaskStream = null;
    // TODO: implement disposeValues
  }
}
