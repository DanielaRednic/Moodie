import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/components/body.dart';
import '../../responsive.dart';
import '../navbar.dart';
import 'components/background.dart';

class _WelcomeScreen extends StatelessWidget{
const _WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const WelcomeScreen(),
          desktop: Row(
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );

  }
}