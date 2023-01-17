import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/movie_details.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../constants.dart';
import '../user_details.dart';
import 'UserPage/user_page.dart';

class NavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kSecondPrimaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
          accountName: Text(user, style: TextStyle(color: Colors.white, fontSize: 18.0)),
          accountEmail: Text(email, style: TextStyle(color: Colors.white , fontSize: 18.0)),
          currentAccountPicture: CircleAvatar(
            child: Image.asset(
              'assets/images/moodie-white.png'
              ),
              backgroundColor: kPrimaryLightColor,
            ),
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
          )
          ),
          ListTile(
            leading: Icon(Icons.table_view_outlined, size: 30, color:Colors.white),
            title: Text("My movies", style: TextStyle(color:Colors.white, fontSize: 18.0)),
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserPage();
                  },
                ),
              ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.rocket_launch_outlined, size: 30, color:Colors.white),
            title: Text("Movie time!", style: TextStyle(color:Colors.white, fontSize: 18.0)),
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
            leading: Icon(Icons.logout, size: 30, color:Colors.white),
            title: Text("Log out", style: TextStyle(color:Colors.white, fontSize: 18.0)),
            onTap: () =>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomeScreen();
                  },
                ),
              ),
          ),
          Row
          (
            children:
            [
              Column
              (
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Container
                  (
                    width: MediaQuery.of(context).size.width*0.2,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/tanooki-logo.png'
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}