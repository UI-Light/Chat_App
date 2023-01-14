import 'package:chat_app2/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  AuthenticationService._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static AppUser? _currentUser;
  static AppUser? get currentUser => _currentUser;

  static GoogleSignInAccount? _user;

  static GoogleSignInAccount get user => _user!;

  //signin with google
  static Future googleLogin() async {
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

      final AppUser user = AppUser(
        id: _user!.id,
        displayName: _user!.displayName ?? "No Name",
        email: _user!.email,
        photoURL: _user!.photoUrl,
      );

      _currentUser = user;

      final query =
          firestore.collection("Users").where("id", isEqualTo: _user!.id);

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        await firestore.collection("Users").add(user.toJson());
      }

      // await FirebaseFirestore.instance.collection('Users').doc(_user!.id).set({
      //   'username': _user!.displayName,
      //   'email': _user!.email,
      //   'photo': _user!.photoUrl
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<AppUser?> getUser(String id) async {
    try {
      _currentUser = await firestore
          .collection("Users")
          .where("id", isEqualTo: id)
          .get()
          .then(
            (data) => AppUser.fromJson(
              data.docs.first.data(),
            ),
          );

      return _currentUser;
    } catch (e) {
      return null;
    }
  }

  // SignIn with Email and password
  static Future<AppUser?> signIn(
      {required String email, required String password}) async {
    try {
      final userCred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = await firestore
          .collection("Users")
          .where("id", isEqualTo: userCred.user!.uid)
          .get()
          .then(
            (data) => AppUser.fromJson(
              data.docs.first.data(),
            ),
          );

      return _currentUser;
    } catch (e) {
      // return e.toString();
      return null;
    }
  }

  //SignUp for new user
  static Future signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final AppUser user = AppUser(
        id: result.user!.uid,
        displayName: username,
        email: email,
      );

      _currentUser = user;

      await firestore.collection('Users').add(user.toJson());
      return _currentUser;
    } catch (e) {
      // return e.toString();
      return null;
    }
  }

  //signout
  static Future logOut() async {
    try {
      _currentUser = null;
      try {
        await googleSignIn.disconnect();
      } catch (e) {}
      await firebaseAuth.signOut();
    } catch (e) {}
  }
}
