import 'package:flutter/material.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.01,
        height: MediaQuery.of(context).size.height * 0.01,
        child: CircularProgressIndicator());
  }
}
