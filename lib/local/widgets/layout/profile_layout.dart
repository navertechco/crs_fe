import 'package:flutter/material.dart';

class ProfileLayoutWidget extends StatelessWidget {
  const ProfileLayoutWidget({Key? key, this.child, this.text})
      : super(key: key);
  final dynamic child;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      SizedBox(
        // top: 0,
        // right: 0,
        child: Image.asset(
          "assets/images/1x/layout.png",
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      child,
    ]);
  }
}
