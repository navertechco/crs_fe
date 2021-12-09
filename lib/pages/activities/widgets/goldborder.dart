import 'package:flutter/material.dart';

class GoldBorderWidget extends StatelessWidget {
  const GoldBorderWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(
              "assets/custom/img/1x/Recurso_211mdpi.png",
              fit: BoxFit.fill,
            ).image,
          ),
        ),
        child: Center(child: child));
  }
}
