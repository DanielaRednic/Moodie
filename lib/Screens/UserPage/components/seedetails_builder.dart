import 'package:flutter/material.dart';
import 'package:moodie/Screens/UserPage/components/see_details.dart';
import 'package:moodie/Screens/navbar.dart';


class SeeDetailsBuilder extends StatelessWidget {
  const SeeDetailsBuilder({Key? key,this.info}) : super(key: key);
  final info;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavBar(),
    body: SeeDetails(info: info)
  );
  }
}