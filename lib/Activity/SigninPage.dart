import 'package:flutter/material.dart';
import 'package:quiz_app_firebase/Activity/HomePage.dart';
import 'package:quiz_app_firebase/Services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login With Google'),
          onPressed: () async {
            final user = await AuthService().signInWithGoogle();
            print('User : ${user.toString()}');
            if (user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              print('Success');
            } else {
              print('Fail');
            }
          },
        ),
      ),
    );
  }
}
