import 'package:flutter/material.dart';

class GoldBorderWidget extends StatelessWidget {
  const GoldBorderWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/custom/img/1x/Recurso 291mdpi.png",
            width: MediaQuery.of(context).size.width * 0.425),
        child
      ],
    );
  }
}
