import 'package:flutter/material.dart'; 
import 'package:naver_crs/common/functions/functions.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../../../../index.dart';

class CustomFooterWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  const CustomFooterWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.normal,
              label:
                  "If you want not any these experience please click on \"Expand\" to amplify the options",
            ),
            CustomKeypadWidget(
                nextlabel: "< Expand >",
                prevlabel: "",
                onNext: () {
                  formKey.currentState!.reset();
                  counter.value++;
                  filterSuggestedExperiences();
                },
                onPrevious: () {},
                nextFontWeight: FontWeight.bold,
                width: 0.002),
          ],
        ),
        Row(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.normal,
              label: "If you want to Reset options click to ->    ",
            ),
            CustomKeypadWidget(
                prevlabel: "< Reset >",
                nextlabel: "",
                onPrevious: () {
                  resetExperiences();
                },
                prevFontWeight: FontWeight.bold,
                width: 0.01),
          ],
        ),
        CustomKeypadWidget(
            nextlabel: "Next >",
            prevlabel: "< Previous ",
            onNext: () {
              paginateDay(context);
              ctrl.refresh();
            },
            onPrevious: () {
              previousDay();
            },
            width: 0.45),
      ],
    );
  }
}
