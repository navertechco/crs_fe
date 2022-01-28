import 'package:get/get.dart';

import '../../../../index.dart';

class DestinationDetailState {
  final Rx<Map<dynamic, dynamic>> localDestination =
      Rx(getContext('destinationdata'));
  DestinationDetailState() {
    explorationDay =
        Rx(getValue(localDestination.value, "exploration_days", def: "0"));
    explorationMode =
        Rx(getValue(localDestination.value, "exploration_mode", def: "0"));
    destinationOption =
        Rx(getValue(localDestination.value, "destination_option", def: "0"));
    travelRhythm =
        Rx(getValue(localDestination.value, "travel_rhythm", def: "0"));

    keyActivities = Rx(getValue(localDestination.value, "key_Activities",
        def: <Map<String, dynamic>>[]));
  }
  var memory = {}.obs;
  Rx<String> destinationOption = "0".obs;
  Rx<String> explorationDay = "0".obs;
  Rx<String> explorationMode = "0".obs;
  Rx<String> travelRhythm = "0".obs;
  Rx<List<Map<String, dynamic>>> keyActivities = Rx([]);

  Rx<List> destinationlist = Rx([]);
}
