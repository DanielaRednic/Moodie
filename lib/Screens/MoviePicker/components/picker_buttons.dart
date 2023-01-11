import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/components/background.dart';

import '../../../constants.dart';
import '../../navbar.dart';

class PickerButtons extends StatefulWidget {
  const PickerButtons({Key? key}) : super(key: key);

  @override
  PickerButtonsState createState() => PickerButtonsState();
}

class PickerButtonsState extends State<PickerButtons> {
  List<String> mood = <String>[
    'Mood',
    'Anything',
    'Adventurous',
    'Angry',
    'Bored',
    'Curious',
    'Depressed',
    'Evil',
    'Happy',
    'Mysterious',
    'Playful',
    'Romantic',
    'Sad',
  ];
  String dropdownValue_mood = 'Mood';
  List<String> genre = <String>[
    'Genre',
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Documentary',
    'Drama',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romantic',
    'Sci-Fi',
    'Superhero',
    'Thriller',
  ];
  String dropdownValue_genre = 'Genre';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255 ,83, 15, 43),
                Color.fromARGB(255 ,255, 153, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(100),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57),
                blurRadius: 5)
            ], 
          ),
          child: DropdownButton<String>(
            onChanged: (String? newValue){
              setState((){
              dropdownValue_mood = newValue!;
              });
            },
            value: dropdownValue_mood,
            items: mood.map<DropdownMenuItem<String>>(
              (String value){
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
              },
            ).toList(),
          ),
            ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            onChanged: (String? newValue){
              setState((){
              dropdownValue_genre = newValue!;
              });
            },
            value: dropdownValue_genre,
            items: genre.map<DropdownMenuItem<String>>(
              (String value){
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
              },
            ).toList(),
          ),
        ],
    ),
    ),
    );
  }
}