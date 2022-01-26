import 'package:get/get.dart';

import '../../../../index.dart';

class DestinationDetailState {
  final Rx<Map<dynamic, dynamic>> localDestination =
      Rx(getContext('destinationdata'));
  DestinationDetailState() {
    explorationDay =
        Rx(getValue(localDestination.value, "exploration_days", def: "9999"));
    explorationMode =
        Rx(getValue(localDestination.value, "exploration_mode", def: "9999"));
    destinationOption =
        Rx(getValue(localDestination.value, "destination_option", def: "9999"));
    travelRhythm =
        Rx(getValue(localDestination.value, "travel_rhythm", def: "9999"));

    keyActivities = Rx(getValue(localDestination.value, "key_Activities",
        def: <Map<String, dynamic>>[]));
  }

  Rx<String> destinationOption = "9999".obs;
  Rx<String> explorationDay = "9999".obs;
  Rx<String> explorationMode = "9999".obs;
  Rx<String> travelRhythm = "9999".obs;
  Rx<List<Map<String, dynamic>>> keyActivities = Rx([]);

  Rx<List> destinationlist = Rx([]);
}
