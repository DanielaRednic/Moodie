import 'package:flutter/material.dart';

import '../../../constants.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key, required this.controller}) : super(key: key);
final TextEditingController controller;

  @override
  _PasswordTextFieldState createState() => new _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      cursorColor: kPrimaryColor,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              obscureText = !obscureText;
            });
          },
          child:obscureText ? const Icon(Icons.visibility_off, color: Colors.white):
          const Icon(Icons.visibility, color: Colors.white)
          ),
        ),
      );
  }
}