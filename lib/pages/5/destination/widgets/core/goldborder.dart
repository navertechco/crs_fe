import 'package:flutter/material.dart';

class GoldBorderWidget extends StatelessWidget {
  const GoldBorderWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: Image.asset(
            "assets/images/1/Recurso_291mdpi.png",
            width: MediaQuery.of(context).size.width * 0.41,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.01,
              top: MediaQuery.of(context).size.height * 0.013),
          child: Image.asset(
            "assets/images/1/Recurso_197mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.355,
              top: MediaQuery.of(context).size.height * 0.077),
          child: Image.asset(
            "assets/images/1/Recurso_198mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        child
      ],
    );
  }
}
