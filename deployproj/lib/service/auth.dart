
import 'package:deployproj/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;
  UserManagement _userFromFirebaseUser(User user){
    return user != null ? UserManagement(uid: user.uid) : null;
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth  = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

     return await _auth.signInWithCredential(credential);
  }

  Future logOut() async {
    try{
      return await _auth.signOut();
    }
    catch(exception){
      print(exception.toString());
      return null;
    }
    
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Result");
      print(result);
      User user = result.user;
      print("User");
      print(user);
      return _userFromFirebaseUser(user);
    }
    catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(exception){
      print(exception.toString());
      return null;
    }
  }
}