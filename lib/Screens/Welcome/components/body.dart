import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'login_and_signup.dart';



class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 2, 
              child: Image.asset(
              'assets/images/moodie-white.png'
              ),
            ),
            Spacer(),
          ],
        ),
        Spacer(),
         Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        // width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
                  ),
                ),
        //SizedBox(height: defaultPadding * 2),
        Expanded(
              flex: 1, 
              child: Image.asset(
              'assets/images/welcome-decor.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft
              ),
            ),
      ],
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: const [
            Spacer(),
          ],
        ),
      ],
    );
  }
}