import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({Key? key, required this.controller}) : super(key: key);
final TextEditingController controller;

  @override
  _ConfirmPasswordTextFieldState createState() => new _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[^ ]+"))],
      maxLength: 35,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      cursorColor: kPrimaryColor,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: 'Confirm password',
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