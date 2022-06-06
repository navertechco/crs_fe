import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/common/index.dart';
// ignore: import_of_legacy_library_into_null_safe

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
                var max = getMaxTrHourValue(currentTravelRhythm.value);
                var left = (leftHours[currentDay.value].value);
                if (left <= max) {
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
                    "",
                    width: 0.3,
                    height: 0.2,
                    customChild: LeisureTimeBypassKeyPad(),
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

class LeisureTimeBypassKeyPad extends StatelessWidget {
  const LeisureTimeBypassKeyPad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            child: Text("   Yes",
                style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)
                    .getStyle()),
            onPressed: () {
              Navigator.pop(context);
            }),
        Text("/",
            style: KTextSytle(
                    context: context,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)
                .getStyle()),
        TextButton(
            child: Text("Next Day",
                style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)
                    .getStyle()),
            onPressed: () async {
              Navigator.pop(context);
              setFormValue(globalctx.memory["days"], currentDay.value,
                  "leisureTime", leftHours[currentDay.value].value);
              promoteExperience("Leisure Time", "promoted");
              await paginateDay(context);
            }),
      ],
    );
  }
}
