import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/movie_details.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../constants.dart';
import '../user_details.dart';

class NavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kSecondPrimaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
          accountName: Text(user, style: TextStyle(color: Colors.white)),
          accountEmail: Text(email, style: TextStyle(color: Colors.white)),
          currentAccountPicture: CircleAvatar(
            child: Image.asset(
              'assets/images/moodie-purple.png'
              ),
              backgroundColor: kPrimaryLightColor,
            ),
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
          )
          ),
          ListTile(
            leading: Icon(Icons.table_view_outlined, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: Text("My movies", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails();
                  },
                ),
              ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.rocket_launch_outlined, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: Text("Movie time!", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MoviePicker();
                  },
                ),
              ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: Text("Log out", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomeScreen();
                  },
                ),
              ),
          ),
          Row(
            children:[
            Expanded(
                flex: 1, 
                child: Image.asset(
                'assets/images/tanooki-logo.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                ),
              )],
            ),
        ],
      )
    );
  }
}