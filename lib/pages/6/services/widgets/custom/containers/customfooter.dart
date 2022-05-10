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
                if (currentDestination.value > 0) {
                  currentDestination.value--;
                  globalDestinationIndex.value =
                      (int.parse(globalDestinationIndex.value) + 1).toString();
                  globalDestinationName.value = "quito";
                  globalDestinationType.value = "arrival";
                  filterSuggestedServices();
                }
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
                resetServices();
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
                currentDestination.value++;
                globalDestinationIndex.value =
                    (int.parse(globalDestinationIndex.value) + 1).toString();
                globalDestinationName.value = "quito";
                globalDestinationType.value = "tour";
                filterSuggestedServices();
              },
            ),
          ],
        ),
      ],
    );
  }
}
