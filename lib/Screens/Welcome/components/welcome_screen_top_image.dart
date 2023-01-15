import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeScreenTopImage extends StatelessWidget {
  const WelcomeScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 1, 
              child: Image.asset(
              'assets/images/moodie-white.png'
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding)
      ],
    );
  }
}