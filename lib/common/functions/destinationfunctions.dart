// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../index.dart'; 
Function promoteDestination = (ctrl, _formKey, destination) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    if (!globalctx.promotedDestinations.contains(destination)) {
      globalctx.promotedDestinations.add(destination);
      destinations = globalctx.memory["destinations"];
    }
    setDestinationState(destination, "promoted");
    updateDraggableDestinations();
    Get.close(1);
  }
};

// Destination Functions
Function getDestinationAirport = () {
  var airport = "quito";
  try { 
    return airport;
  } catch (e) {
    return airport;
  }
};

Function checkPromotedAirport = (destination) {
  bool quitoPromoted = globalctx.promotedDestinations.contains("quito");
  bool gyePromoted = globalctx.promotedDestinations.contains("guayaquil");
  if (destination != "quito" && destination != "guayaquil") {
    return (quitoPromoted || gyePromoted);
  }

  return true;
};

Function getCombinedDestinations = () {
 
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  var result = { 
    ...memoryDestinations, 
  };

  return result;
};

Function processDestinations = (context) {
  // ignore: unrelated_type_equality_checks
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft == 0)) {
    globalDestination.value = globalctx.promotedDestinations[0];

    var destinationDay = []; 
    for (var i = 0; i < totalDays.value; i++) {
      globalctx.experienceDragData.value[i] ??= <Widget>[];
      // globalctx.promotedExperiences[i] ??= [].obs;
    }

    var destinations = getCombinedDestinations();

    for (var destination in allPromotedDestinations) {
      var dest = destinations[destination];
      var explorationDays = dest["explorationDay"];
      var days = int.parse(explorationDays);
      destinationDay.add({...dest, "destination": destination, "days": days});
      destDays.value += days;
    }
    // totalDays.value = destDays;
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays.value;
    selectedIndex.value = selectedIndex.value + 1;
    Get.toNamed("/Experiences");
  } else {
    if (context != null) {
      SweetAlert.show(context,
          curve: ElasticInCurve(),
          title: (dayleft.value > 0)
              ? "You still have $dayleft days to enjoy, do you want to review the other options we have for you?"
              : "Promote any destination is required",
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
    }
  }
};
Function findDestination = (destination) {
  var promotedDestinations = globalctx.promotedDestinations; 
  var index =
      promotedDestinations.indexWhere((element) => element == destination); 
  var result = promotedDestinations[index];
  // }
  return result;
};

Function addDestination = (String destination) {
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.add(destination);
  }
};

Function filterSelectedDestinations = () {
  if (selectedDestinations.contains(arrival["description"])) {
    selectedDestinations.remove(arrival["description"]);
  }
  if (selectedDestinations.contains(departure["description"])) {
    selectedDestinations.remove(departure["description"]);
  }
  selectedDestinations.insert(0, arrival["description"]);
  selectedDestinations.add(departure["description"]);
  globalctx.selectedDestinations.value = [];
  globalctx.destinationDragData.value = <Widget>[];

  for (var selected in selectedDestinations) {
    moveDestination(selected);
  }
};

Function moveDestination = (String destination) {
  setDestinationState(destination, "selected");
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value
      .add(DragDestinationWidget(destination: destination));
};

Function getDestinationId = (String destination) {
  var id = destinationsCatalog
      .toList()
      .where((element) => element["description"] == destination)
      .first;
  return id["code"].toString();
};

Function getDestinationValue = (String destination) {
  var result = [];
  try {
    result = destinationsCatalog
        .firstWhere((e) => e["description"] == destination)["value"];
  } catch (e) {
    print(e);
  }
 
  return result;
};

Function setDestinationState = (destination, state) {
  globalctx.states["destinations"][destination] ??= {}.obs;
  globalctx.states["destinations"][destination]["state"] = state;
};

Function getDestinationState = (destination) {
  globalctx.states["destinations"][destination] ??= {}.obs;
  var state = globalctx.states["destinations"][destination]["state"];
  state ??= "suggested";
  return state;
};

Function updateDraggableDestinations = () {
  if (getDestinationState(arrival["description"]) == "promoted" &&
      getDestinationState(departure["description"]) == "promoted") {
    draggable.value = 1;
  }
};

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
