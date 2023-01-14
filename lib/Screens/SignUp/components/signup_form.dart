import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../../../constants.dart';
import 'confirm_password_field.dart';
import 'custom_password_field.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<LinkedHashMap<String,dynamic>> makeRequest() async{
      const uri = 'http://192.168.0.102:5000/user/add';
      final response = await http.post(Uri.parse(uri),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': usernameController.text,
        'email': emailController.text,
        'pass': passwordController.text,
        'confirm_pass': confirmPasswordController.text
      }));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed creating user');
      }
      
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: TextStyle(color: Colors.white),
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "E-mail",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Icon(Icons.email, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: usernameController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          PasswordTextField(controller: passwordController),
          ConfirmPasswordTextField(controller: confirmPasswordController),
          const SizedBox(height: defaultPadding / 2, ),
          ElevatedButton(
            onPressed: () {
              makeRequest();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
            child: Text("Sign Up".toUpperCase()),
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