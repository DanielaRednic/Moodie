import 'package:flutter/material.dart';
import 'package:moodie/Screens/navbar.dart';

import '../Welcome/components/background.dart';
import 'components/movie_list.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavBar(),
    body: MovieList()
  );
  }
}