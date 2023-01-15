import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodie/Screens/UserPage/user_page.dart';

import '../../../constants.dart';
import 'video_player_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerFlutter extends StatefulWidget {
  const YouTubePlayerFlutter({Key? key}) : super(key: key);

  @override
  State<YouTubePlayerFlutter> createState() => _YouTubePlayerFlutterState();
}

class _YouTubePlayerFlutterState extends State<YouTubePlayerFlutter> {
  final videoURL= "https://www.youtube.com/watch?v=5PSNL1qE6VY";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

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
    String movieTitle = "Avatar";
    String moviePoster = 'https://m.media-amazon.com/images/M/MV5BZDA0OGQxNTItMDZkMC00N2UyLTg3MzMtYTJmNjg3Nzk5MzRiXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UY720_.jpg';
    String movieYear = "2009";
    List<String> movieGenre = ['Action','Adventure', 'Fantasy'];
    String movieDuration = "162";
    String imdbRating = "9.5";
    String rottenRating = "95%";
    String movieDescription = "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.";
    
    String strToDIsplay = "";
  
    for(var genre in movieGenre) {
      strToDIsplay += "$genre ";
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
                  Text("Rotten Tomatoes: "+imdbRating.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0)),
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
        Row(
          children: [
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                  return UserPage();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Great! I'll go see it.",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "I have already seen it",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 0, padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "I want a different movie",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
              ],
            )
          ],
          )
      ],
    );
  }
}

// class GeneratedMovie extends StatelessWidget {
//   const GeneratedMovie({
//     Key? key,
//   }) : super(key: key);

  
// }