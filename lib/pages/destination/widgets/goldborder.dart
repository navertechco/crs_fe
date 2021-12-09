import 'package:flutter/material.dart';

class GoldBorderWidget extends StatelessWidget {
  const GoldBorderWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/custom/img/1x/Recurso_291mdpi.png"),
        Padding(
          padding: const EdgeInsets.all(7),
          child: Image.asset(
            "assets/custom/img/1x/Recurso_197mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.3627,
              top: MediaQuery.of(context).size.height * 0.07),
          child: Image.asset(
            "assets/custom/img/1x/Recurso_198mdpi.png",
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        child
      ],
    );
  }
}
