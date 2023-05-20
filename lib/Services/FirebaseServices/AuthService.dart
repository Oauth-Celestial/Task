import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmanagment/Model/UserModel.dart';
import 'package:taskmanagment/Services/FirebaseServices/FirebaseService.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static siginwithGoogle() async {
    try {
      GoogleSignInAccount? a = await GoogleSignIn().signIn();
      if (a != null) {
        final googleAuth = await a.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await auth.signInWithCredential(credential);
        AppUser user = await UserService.shared.getUser(a);
        print(user);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static signout() async {
    await GoogleSignIn().signOut();

    await auth.signOut();
  }
}
