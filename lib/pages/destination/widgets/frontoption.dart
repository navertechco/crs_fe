import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.destination = "coast"})
      : super(key: key);

  final String destination;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Image.asset(destinations[destination][2],
            width: MediaQuery.of(context).size.width * 0.4),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.005,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(destinations[destination][3]),
        ),
      ),
    ]);
  }
}
