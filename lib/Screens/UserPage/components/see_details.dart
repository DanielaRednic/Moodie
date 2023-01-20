import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../user_details.dart';
import 'package:http/http.dart' as http;

class SeeDetails extends StatefulWidget {
  const SeeDetails({Key? key, this.info}) : super(key: key);
  final info;

  @override
  State<SeeDetails> createState() => _SeeDetails(info);
}

class _SeeDetails extends State<SeeDetails> {
  final info;
  _SeeDetails(this.info);
  bool isLoading = false;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(info["trailer"]);

    super.initState();
    _controller = new YoutubePlayerController(
      initialVideoId:  videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    Future<LinkedHashMap<String,dynamic>> fetchNewMovieRequest(bool addID) async{
      String uri = '$server/movies/rand';
      final user = await UserSecureStorage.getUsername() ?? "Guest";
      print(info["anything"].toString());
      if(addID == true){
        String id = info["movie_id"].toString();
        final addMovie_response = await http.post(Uri.parse('$server/user/movie/add'),headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
              "id": info["movie_id"].toString(),
              "user": user
            }
          )
        );
        if(addMovie_response.statusCode == 200){
          print(jsonDecode(addMovie_response.body));
        }
      }

      final response = await http.post(Uri.parse(uri),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user' : user,
        "anything": info["anything"].toString()
      }));

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching movie');
      }
    }
    
    String movieTitle = info["title"];
    String moviePoster = info["poster"];
    String movieYear = info["year"].toString();
    List<dynamic> movieGenre = info["genre"];
    String movieDuration = info["duration"].toString();
    String imdbRating = info["imdb"].toString();
    String rottenRating = info["rt_rating"].toString();
    String movieDescription = info["description"]; 
    
    String strToDIsplay = "";
  
    for(var genre in movieGenre) {
      strToDIsplay += "${genre[0].toUpperCase()}${genre.substring(1)} ";
    }
    if(isLoading == true){
      return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
    }
    return Scaffold(
      appBar: AppBar(title: Text("Movie details"), backgroundColor: kPrimaryColor, centerTitle: true, automaticallyImplyLeading: true),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          Column(
            children:
            [
            const Card(
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)
                    ),
                    child: Image.network(
                        moviePoster,
                        height: 200,
                        fit:BoxFit.fill
                    )
                  ),
                ],
              ),
                ),
              ),
            ],
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.60,
              height: MediaQuery.of(context).size.height*0.25,
              child: SingleChildScrollView(
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: kPrimaryLightColor.withOpacity(0.5),
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Title: "+movieTitle+" ("+movieYear+")", style: TextStyle(color: Colors.white, fontSize: 18.5, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Duration: "+movieDuration, style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  SizedBox(height: 10),
                  Text("Genre: "+strToDIsplay, style: TextStyle(color: Colors.white, fontSize: 18.0), softWrap: true),
                  SizedBox(height: 10),
                  Text("iMDB: "+imdbRating.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  Text("Rotten Tomatoes: "+rottenRating.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ],
              ),
            ),
              ))
            )
          ] 
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text('Description', style: TextStyle(color: Colors.white, fontSize: 20.0)),
              )
          ] 
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: kPrimaryLightColor.withOpacity(0.5),
                border: Border.all(
                color: kPrimaryLightColor.withOpacity(0),
                ),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
              width: MediaQuery.of(context).size.width*0.94,
              padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                child: Text(movieDescription, style: TextStyle(color: Colors.white, fontSize:16.0))
                ),

              ),)
          ] 
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint('Ready'),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: kPrimaryColor,
                    handleColor: kPrimaryLightColor,
                  ),
                ),
                RemainingDuration(),
                const PlaybackSpeedButton()
              ],
            )
          ],
        ),
      ],
    ));
  }
}
