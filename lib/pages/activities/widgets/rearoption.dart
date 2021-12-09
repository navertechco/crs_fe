import 'package:flutter/material.dart'; 
import 'package:naver_crs/common/index.dart';

class RearOptionWidget extends StatelessWidget {
  const RearOptionWidget(
      {Key? key,
      this.experience = "coast",
      this.description =
          """Lorem Ipsum is simply dummy text of the printing and typesetting 
industry. Lorem Ipsum has been but also the leap into electronic 
typesetting, Lorem Ipsum has been but also................."""})
      : super(key: key);

  final String experience;
  final String description;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> experiences = getContext("experiences");
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
        ),
        child: Image.asset(experiences[experience][2],
            width: MediaQuery.of(context).size.width * 0.4),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.005,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(experiences[experience][3]),
        ),
      ),
    ]);
  }
}
