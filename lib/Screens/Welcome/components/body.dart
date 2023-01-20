import 'package:flutter/material.dart';
import 'package:moodie/user_details.dart';
import '../../../constants.dart';
import 'login_and_signup.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          SizedBox(height: defaultPadding),
            Expanded(
              flex: 1, 
              child: Container(

              width: MediaQuery.of(context).size.width*0.60,
              child: Image.asset('assets/images/moodie-white.png'),
              )
            ),
          SizedBox(height: defaultPadding),
          Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        // width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
        
                ),),
          SizedBox(height: defaultPadding),
          Expanded(
              child: Container(

              width: MediaQuery.of(context).size.width*0.60,
              child: Image.asset('assets/images/decor.png'),
              alignment: Alignment.bottomCenter,
              )
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