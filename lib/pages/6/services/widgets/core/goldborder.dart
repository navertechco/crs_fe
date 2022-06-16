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
              "assets/images/1/Recurso_211mdpi.png",
              width: MediaQuery.of(context).size.width * 0.1,
              fit: BoxFit.fill,
            ).image,
          ),
        ),
        child: Stack(
          children: [
            Center(child: child),
          ],
        ));
  }
}
