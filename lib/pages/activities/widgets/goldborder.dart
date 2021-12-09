import 'package:flutter/material.dart';

class GoldBorderWidget extends StatelessWidget {
  const GoldBorderWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.0),
      child: Stack(
        children: [
          Image.asset("assets/custom/img/1x/Recurso_373mdpi.png",
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.height * 0.3),
          child
        ],
      ),
    );
  }
}
