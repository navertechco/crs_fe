// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';

Function promoteDestination = (ctrl, _formKey, destination, index, type) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    if (!globalctx.promotedDestinations.contains(index)) {
      globalctx.promotedDestinations.add(index);
      destinations = globalctx.memory["destinations"];
    }
    setDestinationState(destination, index, "promoted", type);
    arrivalState.value = "selected";
    departureState.value = "selected";
    if (globalctx.promotedDestinations.isNotEmpty) {
      arrivalState.value = "promoted";
    }

    updateDraggableDestinations();
    updateTotalLeftAccumulated();
    Get.close(1);
  }
};

Function updateDraggableDestinations = () {
  if (arrivalState.value == "promoted" &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
    draggable.value = 1;
  }
  if (arrivalState.value == "promoted" &&
      departureState.value == "promoted" &&
      globalctx.promotedDestinations.length ==
          globalctx.selectedDestinations.length) {
    draggable.value = 0;
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

Function getCombinedDestinations = () {
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  return destinations;
};

Function processDestinations = (context) {
  // ignore: unrelated_type_equality_checks
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft == 0)) {
    var destinationDay = [];
    totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
    globalctx.experienceDragData.value = {};
    for (var i = 0; i < totalDays.value; i++) {
      globalctx.experienceDragData.value[i] ??= <Widget>[];
    }

    var destinations = getCombinedDestinations();
    int idx = 0;
    for (var destination in destinations.entries.toList()) {
      var dest = destinations[idx.toString()];
      var explorationDays = dest["explorationDay"];
      var days = int.parse(explorationDays);
      destinationDay.add({...dest, "destination": destination, "days": days});
      destDays.value += days;
      idx++;
    }
    // totalDays.value = destDays;
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays.value;
    arrival.value = getDestinationById(arrivalPort.value);
    departure.value = getDestinationById(departurePort.value);
    globalDestinationName.value = arrival["description"];
    globalDestinationType.value = "arrival";
    globalDestinationIndex.value = "0";
    resetExperiences();
    selectedIndex.value = pageList.indexOf("Experiences");
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

Function addDestination = (String destination) {
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.add(destination);
  }
};
int idx = 0;
String type = "";

Function filterSelectedDestinations = () {
  if (dayleft.value > 1 &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
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
    idx = 0;
    var destlength = selectedDestinations.length;
    for (var selected in selectedDestinations) {
      type = "tour";
      if (idx == 0) {
        type = "arrival";
      }
      if (idx == destlength - 1) {
        type = "departure";
      }
      moveDestination(selected, idx, type);
      idx++;
    }
  }
};

Function moveDestination = (String destination, int index, String type) {
  setDestinationState(destination, index, "selected", type);
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value.add(DragDestinationWidget(
      destination: destination, index: index, type: type, out: false));
};
Function getDestinationById = (destId) {
  try {
    var dest = destinationsCatalog
        .toList()
        .where((element) => element["code"] == int.parse(destId))
        .first;

    return dest;
  } catch (e) {
    print(e);
  }
};

Function getDestinationIdByName = (String destination) {
  var id = getDestinationByName(destination)["code"].toString();
  return id;
};

Function getDestinationValueByName = (String destination) {
  var result = [];
  try {
    result = getDestinationByName(destination)["value"];
  } catch (e) {
    print(e);
  }

  return result;
};
Function getDestinationByName = (String destination) {
  var result;
  try {
    List<Map<String, dynamic>> list = destinationsCatalog.toList();
    result = list.firstWhere(
        (element) => element["description"].toString() == destination);
  } catch (e) {
    print(e);
  }

  return result;
};

Function setDestinationState = (String dest, index, state, type) {
  globalctx.states["destinations"][index] ??= {}.obs;
  globalctx.states["destinations"][index]["state"] = state;
  globalctx.states["destinations"][index]["type"] = type;
  globalctx.states["destinations"][index]["index"] = index;
  globalctx.states["destinations"][index]["destination"] = dest;
};

Function getDestinationState = (destination, index) {
  var state = "suggested";
  globalctx.states["destinations"][index] ??= {}.obs;
  state = globalctx.states["destinations"][index]["state"] ?? "suggested";
  return state;
};

Function updateTotalLeftAccumulated = () {
  accumulated.value = 0;
  if (destinations.isNotEmpty) {
    for (var destination in destinations.keys) {
      accumulated.value += getDestinationDay(destination) as int;
    }
  }
  dayleft.value = totalDays.value - accumulated.value;
};

Function setDestination = (String destination, index) {
  index = index.toString();
  destinations[index] ??= {};
};

Function setDestinationDay = (String destination, index, value) {
  index = index.toString();
  setDestination(destination, index);
  destinations[index]["explorationDay"] ??= value;
};

Function getLeftAccumulated = (destination, id) {
  leftAccumulated.value = 0;
  totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
  for (String item in destinations.keys) {
    bool exists = item != destination;
    if (exists) {
      leftAccumulated.value -= getDestinationDay(item) as int;
    }
  }
  return leftAccumulated.value;
};

Function getDestinationIndex = (String destination, String type) {
  int destIndex = 0;
  destIndex = globalctx.destinations.indexOf((e) => e == destination);

  if (type == "arrival") {
    destIndex = 0;
  }
  if (type == "departure") {
    destIndex = globalctx.promotedDestinations.length - 1;
  }

  return destIndex;
};

Function getDestinationTravelRhythm = (destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  var trData = processCatalog("travel_rhythm").toList();
  var trRange = trData
      .firstWhere((e) => e["code"] == int.parse(destData["travelRhythm"]));
  return trRange;
};
