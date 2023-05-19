import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmanagment/Model/UserModel.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static UserService shared = UserService();

  checkDocument() async {
    DocumentSnapshot isUser =
        await firestore.collection("Users").doc(auth.currentUser!.uid).get();
    if (isUser.exists) {
      return true;
    } else {
      return false;
    }
  }

  getUserFromFirestore() async {
    DocumentSnapshot userData =
        await firestore.collection("Users").doc(auth.currentUser!.uid).get();
    AppUser user = AppUser.fromJson(userData.data() as Map<String, dynamic>);
    return user;
  }

  Future<AppUser> getUser(GoogleSignInAccount? userData) async {
    bool isUserRegistered = await checkDocument();

    if (isUserRegistered) {
      AppUser user = await getUserFromFirestore();
      return user;
    } else {
      AppUser newUser = AppUser(
          id: auth.currentUser?.uid ?? "",
          userName: userData?.displayName ?? "",
          email: userData?.email ?? "",
          profileUrl: userData?.photoUrl ?? "",
          joinedDate: Timestamp.now());

      await firestore
          .collection("Users")
          .doc(auth.currentUser?.uid ?? "a")
          .set(newUser.toJson());

      return newUser;
    }
  }
}
