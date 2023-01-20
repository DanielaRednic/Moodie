import 'package:flutter/material.dart';
import 'package:moodie/Screens/navbar.dart';

import '../../constants.dart';
import 'components/movie_list.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("My movies & ratings"), backgroundColor: kPrimaryColor, centerTitle: true, automaticallyImplyLeading: true),
    drawer: NavBar(),
    body: MovieList()
  );
  }
}