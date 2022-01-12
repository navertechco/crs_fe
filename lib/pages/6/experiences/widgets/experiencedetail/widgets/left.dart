import 'package:flutter/material.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.35),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.45,
        // color: Colors.red[50],
        child: SingleChildScrollView(
          child: Text("LEFT"),
        ),
      ),
    );
  }
}
