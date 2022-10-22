import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/components/body.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //This is the size of the screen
    return Container( 
      height: size.height,
      width: double.infinity,
      child: Stack(
        children:  <Widget>[],
      )
      );
  }
}