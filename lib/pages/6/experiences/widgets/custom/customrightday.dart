import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import 'index.dart';

class CustomRightDayWidget extends StatelessWidget {
  const CustomRightDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.38),
      child: Column(
        children: [
          Row(
            children: const [
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Date: ",
              ),
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "25TH April 2022",
              ),
            ],
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Destination: Cuenca",
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Row(
              children: [
                Column(
                  children: [
                    CustomTitleWidget(
                      fontWeight: FontWeight.bold,
                      label:
                          "Sugested Experiences\n______________________________________",
                    ),
                    Scrollbar(
                      child: SingleChildScrollView(
                        child: CustomExperiencesListWidget(suggested: true),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomTitleWidget(
                      fontWeight: FontWeight.bold,
                      label:
                          "Selected Experiences\n______________________________________",
                    ),
                    Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: const [
                            CustomExperiencesListWidget(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label:
                    "If you want not any these experience please click on \"Expand\" to amplify the options",
              ),
              CustomKeypadWidget(
                  nextlabel: "< Expand >",
                  prevlabel: "",
                  onNext: () { 
                  },
                  onPrevious: () {},
                  width: 0.002),
            ],
          ),
          CustomKeypadWidget(
              nextlabel: "Next >",
              prevlabel: "< Previous ",
              onNext: () {
                Get.toNamed("/Resume");
              },
              onPrevious: () {
                Get.back();
              },
              width: 0.45),
        ],
      ),
    );
  }
}
