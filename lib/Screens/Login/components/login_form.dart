import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../../../constants.dart';
import '../../SignUp/components/custom_password_field.dart';
import '../../../user_details.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
    }
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
          UserSecureStorage.setUsername(info["username"]);
          UserSecureStorage.setEmail(info["email"]);
          UserSecureStorage.setLoggedIn(true);
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
            maxLength: 50,
            controller: userinfoController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: const TextStyle(color: Colors.white),
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "E-mail / Username",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          PasswordTextField(controller: passwordController),
          const SizedBox(height: defaultPadding / 2, ),
          ElevatedButton(
            onPressed: () async {
              setState((){
                isLoading = true;
              });
              final jsonResponse= await fetchRequest();
              setState((){
                isLoading = false;
              });
              if(jsonResponse.containsKey("error")==false)
              {
                Navigator.pushReplacement(context,MaterialPageRoute(
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
            content: Text(jsonResponse["error"]),
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
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
            child: Text("Log In"),
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
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        ),
          const SizedBox(height: defaultPadding)
        ],
      ),
    );
  }
}