import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Column(
      children: [
        Row(
          children:[
          Column(
            children:
            [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,  // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                        'https://m.media-amazon.com/images/M/MV5BZDA0OGQxNTItMDZkMC00N2UyLTg3MzMtYTJmNjg3Nzk5MzRiXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UY720_.jpg',
                       // width: 300,
                        height: 150,
                        fit:BoxFit.fill
                    )
                  ),
                ],
              ),
              ),
              
            ],
            ),
          ] 
        ),
        SizedBox(height: 30),
        Row(
          
        ),
        SizedBox(height: 30),
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
        SizedBox(height: 30),
      ],
    );
  }
}

// class GeneratedMovie extends StatelessWidget {
//   const GeneratedMovie({
//     Key? key,
//   }) : super(key: key);

  
// }