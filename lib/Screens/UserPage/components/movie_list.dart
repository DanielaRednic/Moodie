import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/navbar.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../user_details.dart';
import 'see_details.dart';
import 'seedetails_builder.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<dynamic>? _movies;

  Future<LinkedHashMap<String,dynamic>> fetchRequest() async{
      final user = await UserSecureStorage.getUsername() ?? "Guest";
      String uri = '$server/user/get/movies?user=$user';
      final response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching movies');
      }
    }
  
  Future<LinkedHashMap<String,dynamic>> getMovieRequest(int id) async{
      final user = await UserSecureStorage.getUsername() ?? "Guest";
      String uri = '$server/movies?id=$id';
      final response = await http.get(Uri.parse(uri));
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching movies');
      }
    }

  void updateRating(String id,String value) async {
    final user = await UserSecureStorage.getUsername() ?? "Guest";
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
  bool isLoading = false;
  bool isDescending = false;
  
  @override
  Widget build(BuildContext context) {
    if (_movies == null) {
      return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
    }
    if (_movies!.isEmpty) {
      return const Center(child: Text("No movies yet :("));
    }

    return Scaffold(

      body: Column(children: [
        TextButton.icon(
          icon:RotatedBox(quarterTurns: 1, child: Icon(Icons.compare_arrows_rounded,size: 28,color: kPrimaryColor),),
          label: Text(isDescending ? 'Descending' : 'Ascending', style: TextStyle(fontSize: 16, color: kPrimaryColor)),
          onPressed: () => setState(() => isDescending = !isDescending),
        ),
        Expanded(child: buildList()),
      ]),
    );
  }

   Widget buildList() => ListView.builder(
      itemCount: _movies?.length,
      itemBuilder: (context, index) {
        final sortedItems = _movies?..sort((item1,item2) => isDescending ? item2['name'].compareTo(item1['name']) : item1['name'].compareTo(item2['name']));
        final item = sortedItems?[index];
        return Column(
          children: <Widget>[
            Container(
            color: kPrimaryLightColor.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Flexible(
                flex: 25,
                child: InkWell
                (
                  child: Padding
                  (
                    padding: const EdgeInsets.all(10.0),
                    child: Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        ClipRRect
                        (
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                          child: Image.network(
                          item["poster"],
                          height: 100,
                          fit:BoxFit.fill)
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                VerticalDivider(),
                Flexible(
                  flex: 25,
                  child:Text(item["name"] + ' (' + item["year"].toString() + ')', style: TextStyle(color: Colors.white, fontSize: 14.0), softWrap: true, maxLines: 4, overflow: TextOverflow.ellipsis),
                ),
                VerticalDivider(),

                Flexible(
                flex: 7,
                child: Container(
                child: Text(item["rating"].toString(), style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold))
                  )
                ),
            Flexible(
              flex: 18,
              
            child: DropdownButton<String>
            (
              icon: const Icon(Icons.star_half_outlined, color: kPrimaryColor),
              elevation: 16,
              underline: Container(
              height: 2,
              color: kPrimaryLightColor.withOpacity(0),
              ),
              onChanged: (newValue) 
              {
                updateRating(item["id"].toString(), newValue.toString());
                  setState(() {
                    item["rating"]=newValue.toString();
                  });
              },
              items: <String>['10','9.5', '9', '8.5','8','7.5', '7','6.5', '6','5.5', '5','4.5', '4','3.5', '3','2.5', '2','1.5', '1','0']
                  .map<DropdownMenuItem<String>>((String value) 
                  {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value));
                  }).toList(),
            )
          
          ),
          Flexible(
            flex: 20,

           child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255 ,83, 15, 43),
                Color.fromARGB(255 ,255, 153, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57),
                blurRadius: 5)
            ], 
          ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 20
            ),
            onPressed:() async{
              setState(() {
              isLoading = true;
            });
            final jsonResponse = await getMovieRequest(item["id"]);
            if(jsonResponse["return"]== true){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SeeDetailsBuilder(info:jsonResponse);
                },
              ),
              );
            }
            setState(() {
              isLoading = false;
            });
          },
              child: const Text('Details',style: TextStyle(fontSize: 12.0)),
            ),
            ),
          )
            ],
            )
            ),
            Divider(),
            ],
            );
      },
    );

  }


