import 'package:flutter/material.dart';
import 'package:moodie/Screens/MoviePicker/components/buttons.dart';
import 'package:moodie/Screens/navbar.dart';

import '../../constants.dart';
import '../Welcome/components/background.dart';

class MoviePicker extends StatelessWidget {
  const MoviePicker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Movie time!"), backgroundColor: kPrimaryColor, centerTitle: true, automaticallyImplyLeading: true),
    drawer: NavBar(),
    body: const HomePage(),
  );
  }
}