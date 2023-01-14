// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:video_player/video_player.dart';

// import '../../../constants.dart';
// import 'video_player_widget.dart';


// class Trailer extends StatefulWidget{
//   @override
//   _TrailerState createState() => _TrailerState();
// }

// class _TrailerState extends State<Trailer>{
//   final url='https://www.youtube.com/watch?v=5PSNL1qE6VY';
//   late VideoPlayerController controller;
  
//   @override
//   void initState() {
//     super.initState();
//     controller = VideoPlayerController.asset(url)
//       ..addListener(() => setState(() {}))
//       ..setLooping(true)
//       ..initialize().then((_) => controller.play());
//   }

//   @override
//   void dispose(){
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context)
//   {
//     return VideoPlayerWidget(controller: controller);
//   }
// }

// class GeneratedMovie extends StatelessWidget {
//   const GeneratedMovie({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children:[
//           Column(
//             children:
//             [
//             Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)))),
//               InkWell(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,  // add this
//                 children: <Widget>[
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.0),
//                       topRight: Radius.circular(8.0),
//                     ),
//                     child: Image.network(
//                         'https://m.media-amazon.com/images/M/MV5BZDA0OGQxNTItMDZkMC00N2UyLTg3MzMtYTJmNjg3Nzk5MzRiXkEyXkFqcGdeQXVyMjUzOTY1NTc@._V1_FMjpg_UY720_.jpg',
//                        // width: 300,
//                         height: 150,
//                         fit:BoxFit.fill
//                     )
//                   ),
//                 ],
//               ),
//               ),
              
//             ],
//             ),
//           ] 
//         ),
//         SizedBox(height: 30),
//         Row(
          
//         ),
//         SizedBox(height: 30),
//         Row(

//         ),
//         SizedBox(height: 30),
//       ],
//     );
//   }
// }