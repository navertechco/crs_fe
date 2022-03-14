import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class TravelChips extends HookWidget {
  TravelChips({Key? key, required this.ctrl, required this.counter})
      : super(key: key);
  final ValueNotifier<int> counter;
  final ExperiencesController ctrl;

  @override
  Widget build(BuildContext context) {
    // useEffect(() {
    //   destinationOption.value = "0";
    //   travelRhythm.value = "0";
    //   keyActivities.value = <String>[];
    // }, [stream, counter.value]);

    var index = getDestinationIndex(
        globalDestinationName.value, globalDestinationType.value);
    Rx<dynamic> keyActivities = Rx(getFormValue(
        globalctx.memory["destinations"], index, "keyActivities", <String>[]));

    Rx<dynamic> destinationOption = Rx(getFormValue(
        globalctx.memory["destinations"], index, "destinationOption", "0"));

    Rx<dynamic> travelRhythm = Rx(getFormValue(
        globalctx.memory["destinations"], index, "travelRhythm", "0"));
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Column(
              children: [
                CustomTitleWidget(
                  fontWeight: FontWeight.bold,
                  label: "Filtered Experiences by:",
                  color: Colors.white
                ),
                Obx(() {
                  return Column(
                    children: [
                      if (keyActivities.value.length > 0)
                        InputChip(
                          deleteIcon: Icon(Icons.cancel),
                          label: Text("${keyActivities.value}"),
                          onSelected: (bool value) {},
                          onDeleted: () {
                            keyActivities.value = [];
                          },
                        ),
                      if (destinationOption.value != "0")
                        InputChip(
                          deleteIcon: Icon(Icons.cancel),
                          label: Text("${destinationOption.value}"),
                          onSelected: (bool value) {},
                          onDeleted: () {
                            destinationOption.value = "0";
                          },
                        ),
                      if (travelRhythm.value != "0")
                        InputChip(
                          deleteIcon: Icon(Icons.cancel),
                          label: Text("${travelRhythm.value}"),
                          onSelected: (bool value) {},
                          onDeleted: () {
                            travelRhythm.value = "0";
                          },
                        ),
                    ],
                  );
                })
              ],
            )));
  }
}
