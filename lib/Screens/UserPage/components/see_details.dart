import 'package:flutter/material.dart';
import 'package:moodie/Screens/UserPage/user_page.dart';

import '../../../constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeeDetails extends StatefulWidget {
  const SeeDetails({Key? key, this.info}) : super(key: key);
  final info;

  @override
  State<SeeDetails> createState() => _YouTubePlayerFlutterState(info);
}

class _YouTubePlayerFlutterState extends State<SeeDetails> {
  final info;
  _YouTubePlayerFlutterState(this.info);

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(info["trailer"]);

    _controller = new YoutubePlayerController(
      initialVideoId:  videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          Column(
            children:
            [
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)
                    ),
                    child: Image.network(
                        moviePoster,
                       // width: 300,
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
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: kPrimaryLightColor.withOpacity(0.5),
                child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Title: "+movieTitle+" ("+movieYear+")", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
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
              )
            )
          ] 
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Description', style: TextStyle(color: Colors.white, fontSize: 20.0)),
              )
          ] 
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: kPrimaryLightColor.withOpacity(0.5),
                border: Border.all(
                color: kPrimaryLightColor.withOpacity(0.5),
                ),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
              width: MediaQuery.of(context).size.width*0.94,
              //color: kPrimaryLightColor.withOpacity(0.5),
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
                const PlaybackSpeedButton(),
              ],
            )
          ],
        ),
        SizedBox(height: 5),
        
      ],
    );
  }
}

// class GeneratedMovie extends StatelessWidget {
//   const GeneratedMovie({
//     Key? key,
//   }) : super(key: key);

  
// }