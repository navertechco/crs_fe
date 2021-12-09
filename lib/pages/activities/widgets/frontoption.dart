import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';

class FrontOptionWidget extends StatelessWidget {
  const FrontOptionWidget({Key? key, this.experience = "coast"})
      : super(key: key);

  final String experience;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> experiences = getContext("experiences");
    return Stack(children: [
      Positioned(
        
        child: Image.asset(experiences[experience][2],
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.13),
      ),
      // Padding(
      //   padding: EdgeInsets.only(
      //     top: MediaQuery.of(context).size.height * 0.04,
      //     left: MediaQuery.of(context).size.width * 0.005,
      //   ),
      //   child: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Image.asset(experiences[experience][3]),
      //   ),
      // ),
    ]);
  }
}
