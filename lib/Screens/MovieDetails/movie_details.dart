import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/components/generated_movie.dart';
import 'package:moodie/Screens/MoviePicker/components/picker_buttons.dart';
import 'package:moodie/Screens/navbar.dart';

import '../Welcome/components/background.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key, this.info}) : super(key: key);
  final info;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavBar(),
    body: YouTubePlayerFlutter(info: info)
  );
  }
}