import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class KeypadWidget extends StatelessWidget {
  const KeypadWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.3,
          top: MediaQuery.of(context).size.height * 0.0),
      child: Row(children: [
        TextButton(
          child: Text("Accept",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  .getStyle()),
          onPressed: () {
            promoteDayExperience(experience);
            setExperienceState(experience, "promoted");
            Get.close(1);
          },
        ),
        TextButton(
          child: Text("Cancel",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  .getStyle()),
          onPressed: () {
            Get.close(1);
          },
        ),
      ]),
    );
  }
}
