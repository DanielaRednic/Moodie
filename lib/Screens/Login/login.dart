import 'package:flutter/material.dart';
import '../../responsive.dart';
import '../../constants.dart';
import '../Welcome/components/background.dart';
import 'components/login_top_image.dart';
import 'components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
          ),
        ),
      ),
    );
  }
}

  class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}


