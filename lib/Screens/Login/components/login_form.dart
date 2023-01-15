import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../../../constants.dart';
import '../../Login/login.dart';
import '../../SignUp/components/custom_password_field.dart';
import '../../../user_details.dart';

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
      String uri = '$server/user/verify?$queryParameters';
      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        uri = '$server/user/get/details?user=${userinfoController.text}';
        final details = await http.get(Uri.parse(uri));
        if(details.statusCode == 200){
          final info = jsonDecode(details.body);
          setName(info["username"]);
          setEmail(info["email"]);
        }
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
            onPressed: () async {
              final jsonResponse= await fetchRequest();
              if(jsonResponse.containsKey("error")==false)
              {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MoviePicker();
                },
              ),
            );
              }
              else
        {
          showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('Oops!'),
            content: Text("Username or password is incorrect!"),
          actions:[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context)
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pop(context)
            ),
            ],
          ),
          );
        }
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
          const SizedBox(height: defaultPadding)
        ],
      ),
    );
  }
}