import 'package:flutter/material.dart';
import 'package:moodie/Screens/MovieDetails/movie_details.dart';
import 'package:moodie/Screens/MoviePicker/movie_picker.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';

import '../constants.dart';
import '../user_details.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar>{
  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final username = await UserSecureStorage.getUsername() ?? "Guest";
    final email = await UserSecureStorage.getEmail() ?? "";

    setState(() {
      controllerUsername.text = username;
      controllerEmail.text = email;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kSecondPrimaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
          accountName: Text(controllerUsername.text, style: const TextStyle(color: Colors.white)),
          accountEmail: Text(controllerEmail.text, style: const TextStyle(color: Colors.white)),
          currentAccountPicture: CircleAvatar(
            child: Image.asset(
              'assets/images/moodie-purple.png'
              ),
              backgroundColor: kPrimaryLightColor,
            ),
          decoration: const BoxDecoration(
            color: kPrimaryLightColor,
          )
          ),
          ListTile(
            leading: const Icon(Icons.table_view_outlined, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: const Text("My movies", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails();
                  },
                ),
              );
            }
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.rocket_launch_outlined, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: Text("Movie time!", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MoviePicker();
                  },
                ),
              );
            }
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, size: 30, color:Color.fromARGB(255, 26, 3, 56)),
            title: const Text("Log out", style: TextStyle(color:Color.fromARGB(255, 26, 3, 56), fontSize: 18.0)),
            onTap: () {
              setState(() {
                UserSecureStorage.setLoggedIn(false);
                UserSecureStorage.deleteEmail();
                UserSecureStorage.deleteUsername();
              });
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(
                        builder: (context) {
                        return WelcomeScreen();
                        },
                      ),
                    );
              }
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