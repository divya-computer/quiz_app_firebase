import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign in
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    // print('credential : ${credential.toString()}');
    // print('User : ${gUser.toString()}');
    // print('Auth : ${gAuth.}');

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
