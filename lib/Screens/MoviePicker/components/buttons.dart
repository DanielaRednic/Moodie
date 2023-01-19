import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/movie_details.dart';
import 'package:moodie/user_details.dart';

import '../../Welcome/welcome_screen.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Multi Select widget
// This widget is reusable
int maximumChoices = 15;
class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];
  bool isLoading = false;
// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        if(_selectedItems.length< maximumChoices) {
          _selectedItems.add(itemValue);
        }
        else
        {
          showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('Oops!'),
            content: Text('You can only select up to 15 elements!'),
          actions:[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context)
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pop(context)
            ),
            ],
          ),
          );
        }
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true){
      return const Center(child: CircularProgressIndicator());
    }
    return AlertDialog(
      title: const Text('Select your choices'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

// Implement a multi select on the Home screen
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedItems = [];
  bool isLoading = false;
  void _showMultiSelectMood() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> mood = [
    'Adventurous','Angry','Bored', 'Curious', 'Depressed',
    'Evil', 'Happy', 'Mysterious', 'Playful', 'Romantic', 'Sad'];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: mood);
      },
    
    );

    // Update UI
    if (results != null) {
      setState(() {
        for(String itr in results) {
          if(!_selectedItems.contains(itr))
          {
            _selectedItems.add(itr);
          }
        }
      });
    }
  }
  void _showMultiSelectLength() async {
    // a list of selectable movie lengths
    final List<String> time = [
    'over 3 hours', '2-3 hours', 'over 2 hours', '1.5-2 hours', 'under 1.5 hours'];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: time);
      },
    
    );
    if (results != null) {
      setState(() {
        for(String itr in results) {
          if(!_selectedItems.contains(itr))
          {
            _selectedItems.add(itr);
          }
        }
      });
    }
  }

    void _showMultiSelectGenre() async {
    // a list of selectable genres
    final List<String> genre = [
    'Action', 'Adventure', 'Animation', 'Comedy', 'Documentary', 'Drama', 'Fantasy', 'Horror',
    'Mystery', 'Romantic', 'Sci-Fi', 'Superhero', 'Thriller',];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: genre);
      },
    
    );

    // Update UI
    if (results != null) {
      setState(() {
        for(String itr in results) {
          if(!_selectedItems.contains(itr))
          {
            _selectedItems.add(itr);
          }
        }
      });
    }
  }
  void _showMultiSelectGrade() async {
    final List<String> grade = [
    '10','9.5','9','8.5','8','7.5','7','6.5','6','5.5','5','4.5','4','Less than 4',];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: grade);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        for(String itr in results) {
          if(!_selectedItems.contains(itr))
          {
            _selectedItems.add(itr);
          }
        }
      });
    }
  }

   void _showMultiSelectYear() async {
    final List<String> year = [
    '2023','2022','2021','2020','2019','2018','2017','2016','2015','2014','2013','2012',
    '2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001','2000'];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: year);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        for(String itr in results) {
          if(!_selectedItems.contains(itr))
          {
            _selectedItems.add(itr);
          }
        }
      });
    }
  }
  Future<LinkedHashMap<String,dynamic>> fetchRequest() async{
      String uri = '$server/movies/rand';
      print(jsonEncode(_selectedItems));
      final user = await UserSecureStorage.getUsername() ?? "Guest";
      final response = await http.post(Uri.parse(uri),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'filters': jsonEncode(_selectedItems),
        'id' : "0",
        'user' : user
      }));

      if(response.statusCode == 200){
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      }else {
        throw Exception('Failed fetching movie');
      }
    }
  @override
  Widget build(BuildContext context) {
    if (isLoading == true){
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              SizedBox(height: 100),
               Wrap(
                spacing: 10,
                children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              onPressed: _showMultiSelectMood,
              child: const Text('Mood',style: TextStyle(fontSize: 20.0)),
            ),
            ),
            SizedBox(width: 25),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 20
            ),
              onPressed: _showMultiSelectGenre,
              child: const Text('Genre',style: TextStyle(fontSize: 20.0)),
            ),
            ),
            SizedBox(width: 25),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 20
            ),
              onPressed: _showMultiSelectGrade,
              child: const Text('Min. grade',style: TextStyle(fontSize: 20.0)),
            ),
            ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Divider(
              height: 10,
            ),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 20
            ),
              onPressed: _showMultiSelectLength,
              child: const Text('Length',style: TextStyle(fontSize: 20.0)),
            ),
            ),
            SizedBox(width: 25),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 20
            ),
              onPressed: _showMultiSelectYear,
              child: const Text('Year',style: TextStyle(fontSize: 20.0)),
            ),
            ),
            ],),
            SizedBox(height: 100),
          ElevatedButton(
          onPressed: () async{
            setState(() {
              isLoading = true;
            });
            final jsonResponse= await fetchRequest();
            if(jsonResponse.isNotEmpty){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(info: jsonResponse,selecteditems: _selectedItems);
                },
              ),
            );
            }
            setState(() {
              isLoading = false;
            });
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Pick my movie!",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async{
            final jsonResponse= await fetchRequest();
            if(jsonResponse.isNotEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(info: jsonResponse);
                },
              ),
            );
            }
          },
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(60, 141, 141, 141), elevation: 20, padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0))),
          child: Text(
            "Anything goes!",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
          ],
        ),
      ),
    );
  }
  }
