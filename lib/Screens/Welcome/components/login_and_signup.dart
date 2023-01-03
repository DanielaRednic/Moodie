import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Login/login.dart';
import '../../SignUp/signup.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
            child: Text(
              "Login".toUpperCase(),
              style: TextStyle(color: Colors.white)
            ),
          ),
       ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Sign Up".toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}