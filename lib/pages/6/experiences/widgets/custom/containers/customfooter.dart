import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../../../../index.dart';

class CustomFooterWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  GlobalKey<FormState> formKey;
  CustomFooterWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 100, height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
        Row(
          children: [
            TextButton(
              child: Text("Previous",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () {
                previousDay();
              },
            ),
            TextButton(
              child: Text("Reset",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () {
                resetExperiences();
              },
            ),
            TextButton(
              child: Text("Next",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () async {
                if ((leftHours[currentDay.value].value * 60) <= 5) {
                  if (formKey.currentState != null) {
                    if (formKey.currentState!.validate()) {
                      await paginateDay(context);
                    }
                  }
                } else {
                  showCustomDialog(
                    context,
                    Text(
                        "You have ${getTimeStringFromDouble(leftHours[currentDay.value].value)} hours left, would you like to assign another experience?",
                        style: KTextSytle(
                                context: context,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)
                            .getStyle()),
                    "Close",
                    backgroundColor: Colors.white,
                    buttonColor: Colors.black87,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
