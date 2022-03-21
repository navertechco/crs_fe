import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';
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
              onPressed: () {
                paginateDay(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
