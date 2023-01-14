import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  //signin with google
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      await FirebaseFirestore.instance.collection('Users').doc(_user!.id).set({
        'username': _user!.displayName,
        'email': _user!.email,
        'photo': _user!.photoUrl
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // SignIn with Email and password
  Future signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return e.toString();
    }
  }

  //SignUp for new user
  Future signUp(
      {required String username,
      required String email,
      required String password,
      required String confirmPassword}) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(result.user!.uid)
          .set({'username': username, 'email': email});
      return result.user;
    } catch (e) {
      return e.toString();
    }
  }

  //signout
  Future logOut() async {
    await googleSignIn.disconnect();
    firebaseAuth.signOut();
  }
}
