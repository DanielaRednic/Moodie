import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../../../constants.dart';
import '../../Login/login.dart';
import '../../SignUp/components/custom_password_field.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController userinfoController = TextEditingController();

    Future<LinkedHashMap<String,dynamic>> fetchRequest() async{
      final queryParameters='user=${userinfoController.text}&pass=${String.fromCharCodes(utf8.encode(passwordController.text))}';
      final uri = '$server/user/verify?$queryParameters';
      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching user');
      }
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: userinfoController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: TextStyle(color: Colors.white),
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "E-mail / Username",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          PasswordTextField(controller: passwordController),
          const SizedBox(height: defaultPadding / 2, ),
          ElevatedButton(
            onPressed: () {
              fetchRequest();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
            child: Text("Log In".toUpperCase()),
          ),
          ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WelcomeScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Home".toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
          const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck(
          //   login: false,
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return LoginScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}