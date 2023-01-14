// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatelessWidget {
//   final VideoPlayerController controller;

//   const VideoPlayerWidget({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => 
//     controller != null && controller.value.initialized
//     ? Container (alignment: Alignment.center, child: buildVideo())
//     : Container(
//       height: 100,
//       child: Center(child:CircularProgressIndicator()),
//     );

//     Widget buildVideo() => buildVideoPlayer();

//     Widget buildVideoPlayer() => VideoPlayer(controller);
  
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
    ),
);

YoutubePlayer(
    controller: _controller,
    showVideoProgressIndicator: true,
    videoProgressIndicatorColor: Colors.amber,
    progressColors: ProgressColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
    ),
    onReady () {
        _controller.addListener(listener);
    },
),
YoutubePlayerBuilder(
    player: YoutubePlayer(
        controller: _controller,
    ),
    builder: (context, player){
        return Column(
            children: [
                // some widgets
                player,
                //some other widgets
            ],
        );
    ),
),