import 'package:firebase_auth/firebase_auth.dart';
import 'package:pexels_api/models/usermodel.dart';

//need authentication for using firebase database

FirebaseAuth _auth = FirebaseAuth.instance;

UserId? _userFromFirebase(User user) {
  // ignore: unnecessary_null_comparison
  return user != null ? UserId(uId: user.uid) : null;
}

//to sign in Anonymously
Future signInAnom() async {
  try {
    UserCredential result = await _auth.signInAnonymously();
    User? firebaseUser = result.user;
    return _userFromFirebase(firebaseUser!);
  } catch (e) {
    print(e);
  }
}
