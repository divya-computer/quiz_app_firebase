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
        body: Stack(
      children: [
        Image.asset(
          'images/coverimage.jpeg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 150.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/googleicon.jpeg'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                final user = await AuthService().signInWithGoogle();
                print('User : ${user.toString()}');
                if (user != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  print('Success');
                } else {
                  print('Fail');
                }
              },
            ),
          ),
        )
      ],
    )
        // Center(
        //   child: ElevatedButton(
        //     child: Text('Login With Google'),
        //     onPressed: () async {
        //       final user = await AuthService().signInWithGoogle();
        //       print('User : ${user.toString()}');
        //       if (user != null) {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => HomePage()));
        //         print('Success');
        //       } else {
        //         print('Fail');
        //       }
        //     },
        //   ),
        // ),
        );
  }
}
