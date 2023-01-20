import 'package:flutter/material.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/user_details.dart';

import '../../Login/login.dart';
import '../../SignUp/signup.dart';
import '../../UserPage/user_page.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(UserSecureStorage.getLoggedIn() != true)
        Hero(
          tag: "login_btn",
         child: SizedBox(
          width: 225,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
            child: Text(
              "Log In",
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
            ),
          ),
          ),
       ),
        const SizedBox(height: 16),
        if(UserSecureStorage.getLoggedIn() != true)
        SizedBox(
          width: 225,
          height: 45,
        child: ElevatedButton(
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
              backgroundColor: const Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Sign Up",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ),
        // const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return MoviePicker();
        //         },
        //       ),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
        //   child: Text(
        //     "Movie Picker".toUpperCase(),
        //     style: const TextStyle(color: Colors.white),
        //   ),
        // ),
        // const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return UserPage();
        //         },
        //       ),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
        //   child: Text(
        //     "Movies".toUpperCase(),
        //     style: const TextStyle(color: Colors.white),
        //   ),
        // ),
      ],
    );
  }
}