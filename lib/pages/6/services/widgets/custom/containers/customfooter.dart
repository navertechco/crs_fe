 

import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../../controller.dart';

class CustomFooterWidget extends StatelessWidget {
  final ServicesController ctrl;
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
                previousDestination();
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
                resetCurrentDestinationServices();
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
                      await paginateDestination(context);
                    }
                  }
                } else {
                  showCustomDialog(
                    context,
                    Text(
                        "You have ${getTimeStringFromDouble(leftHours[currentDay.value].value)} hours left, would you like to assign another service?",
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
