import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/components/generated_movie.dart';
import 'package:moodie/Screens/navbar.dart';

import '../Welcome/components/background.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key, this.info,this.selecteditems}) : super(key: key);
  final info;
  final selecteditems;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavBar(),
    body: YouTubePlayerFlutter(info: info,selecteditems: selecteditems)
  );
  }
}