import 'package:flutter/material.dart';

// Multi Select widget
// This widget is reusable
class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
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

  void _showMultiSelectMood() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> mood = [
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
    'Sad'
    ];

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
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> time = [
    'over 3 hours',
    '2-3 hours',
    'over 2 hours',
    '1.5-2 hours',
    'under 1.5 hours'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: time);
      },
    
    );
  }

    void _showMultiSelectGenre() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> genre = [
    'Anything',
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
    '10',
    '9.5',
    '9',
    '8.5',
    '8',
    '7.5',
    '7',
    '6.5',
    '6',
    '5.5',
    '5',
    '4.5',
    '4',
    'Less than 4',
    ];

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
    '2023','2022','2021','2020','2019','2018','2017','2016','2015','2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004',
    '2003','2002','2001','2000','1999','1998','1997','1996','1995','1994','1993','1992','1991','1990','1989','1988','1987','1986','1985','1984',
    '1983','1982','1981','1980','1979','1978','1977','1976','1975','1974','1973','1972','1971','1970','1969','1968','1967','1966','1965','1964',
    '1963','1962','1961','1960','1959','1958','1957','1956','1955','1954','1953','1952','1951','1950','1949','1948','1947','1946','1945','1944',
    ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            ),
            // use this button to open the multi-select dialog
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
            ),
              onPressed: _showMultiSelectMood,
              child: const Text('Mood'),
            ),
            ),
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
            ),
              onPressed: _showMultiSelectGenre,
              child: const Text('Genre'),
            ),
            ),
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
            ),
              onPressed: _showMultiSelectGrade,
              child: const Text('Min. grade'),
            ),
            ),
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
            ),
              onPressed: _showMultiSelectLength,
              child: const Text('Length'),
            ),
            ),
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
            ),
              onPressed: _showMultiSelectYear,
              child: const Text('Year'),
            ),
            ),
          ],
        ),
      ),
    );
  }
  }