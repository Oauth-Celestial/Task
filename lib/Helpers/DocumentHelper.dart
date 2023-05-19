import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentHelper {
  static Map<String, dynamic> convertToJson({required DocumentSnapshot doc}) {
    return doc.data() as Map<String, dynamic>;
  }
}
