import "package:firebase_auth/firebase_auth.dart";
import 'package:jio/models/user.dart';
import 'package:jio/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get userStream {
    return _auth.onAuthStateChanged
    .map(userFromFirebaseUser);
  }

  // sign in with email & pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & pw
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document with the uid
      await DatabaseService(uid: user.uid).updateUserData(user.uid, name, email);

      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }



}