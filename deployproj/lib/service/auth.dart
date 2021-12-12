
import 'package:deployproj/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserManagement _userFromFirebaseUser(User user){
    return user != null ? UserManagement(uid: user.uid) : null;
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