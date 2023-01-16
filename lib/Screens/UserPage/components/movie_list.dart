import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/navbar.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../user_details.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<dynamic>? _movies;
  String _selectedRating= "N/A";

  Future<LinkedHashMap<String,dynamic>> fetchRequest() async{
      String uri = '$server/user/get/movies?user=$user';
      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching movies');
      }
    }

  void updateRating(String id,String value) async {
    String uri = '$server/rating?value=$value';
      final response = await http.post(Uri.parse(uri),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': user,
        'id': id
      }));

      if(response.statusCode == 200){
      }else {
        throw Exception('Failed fetching user');
      }
    }

  void _loadMovies() async {
    var movies = await fetchRequest();
    setState(() {
      _movies = movies["movies"];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    if (_movies == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (_movies!.isEmpty) {
      return Center(child: Text("No movies yet :("));
    }
    return ListView.builder(
      itemCount: _movies?.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Image.network(_movies![index]["poster"]),
            Text(_movies![index]["name"] + ' (' + _movies![index]["year"].toString() + ')'),
            Text(_movies![index]["rating"].toString()),
            DropdownButton<String>(
              onChanged: (newValue) {
                updateRating(_movies![index]["id"].toString(), newValue.toString());
                setState(() {
                  _movies![index]["rating"]=newValue.toString();
                });
              },
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        );
      },
    );
  }
}

