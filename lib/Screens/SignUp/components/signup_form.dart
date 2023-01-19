import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../../../constants.dart';
import 'confirm_password_field.dart';
import 'custom_password_field.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  if(isLoading == true){
      return const Center(child: CircularProgressIndicator());
    }

  Future<LinkedHashMap<String,dynamic>> makeRequest() async{
      const uri = '$server/user/add';
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
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[^ ]+"))],
            maxLength: 50,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            style: const TextStyle(color: Colors.white),
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "E-mail",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Icon(Icons.email, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[^ ]+"))],
              maxLength: 30,
              controller: usernameController,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          PasswordTextField(controller: passwordController),
          ConfirmPasswordTextField(controller: confirmPasswordController),
          const SizedBox(height: defaultPadding / 2, ),
          ElevatedButton(
            onPressed: () async{
              setState(() {
                isLoading = true;
              });
              final jsonResponse= await makeRequest();
              setState((){
                isLoading = false;
              });
              if(jsonResponse.containsKey("error")==false)
              {
                showDialog(context: context, builder: (context) =>
                AlertDialog(
                  title: Text('Great!'),
                  content: Text('Account created succesfully!'),
                actions:[
                  TextButton(
                        child: Text('Ok'),
                        onPressed: () { 
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),);
                        }
                      ),
                    ],
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
            child: Text("Sign Up"),
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
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}