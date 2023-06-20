import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future signInAnonymous()async{
    try {
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    } catch (e) {
      print("Anon Error $e");
    }
    return null;
  }


}
