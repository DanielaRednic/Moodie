import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/components/generated_movie.dart';
import 'package:moodie/Screens/navbar.dart';

import '../Welcome/components/background.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key, this.info,this.selecteditems,required this.ids_list}) : super(key: key);
  final info;
  final selecteditems;
  List<String> ids_list;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    drawer: NavBar(),
    body: YouTubePlayerFlutter(info: info,selecteditems: selecteditems,ids_list: ids_list)
  );
  }
}