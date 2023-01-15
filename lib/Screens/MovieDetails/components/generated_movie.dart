import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'video_player_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerFlutter extends StatefulWidget {
  const YouTubePlayerFlutter({Key? key, this.info}) : super(key: key);
  final info;

  @override
  State<YouTubePlayerFlutter> createState() => _YouTubePlayerFlutterState(info);
}

class _YouTubePlayerFlutterState extends State<YouTubePlayerFlutter> {
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
                        info["poster"],
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