// ignore_for_file: prefer_function_declarations_over_variables
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalertv2/sweetalertv2.dart';

// ██████╗ ███████╗███████╗████████╗██╗███╗   ██╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
// ██╔══██╗██╔════╝██╔════╝╚══██╔══╝██║████╗  ██║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
// ██║  ██║█████╗  ███████╗   ██║   ██║██╔██╗ ██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
// ██║  ██║██╔══╝  ╚════██║   ██║   ██║██║╚██╗██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
// ██████╔╝███████╗███████║   ██║   ██║██║ ╚████║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
// ╚═════╝ ╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## dragDestination
/// *__Method to drag a destinatio option widget to left container and account it__*
///
///### Uses:
/// ```dart
///   onAccept = (String destination) {
///      dragDestination(destination);
///    };
/// ```
/// ### Returns:
///```dart
/// void
///```
dragDestination(destination) {
  addDestination(destination);
  filterDestinations();
}

/// ## paginateDestination
/// *__Method to get any property in data__*
///
///### Uses:
/// ```dart
///          onPressed: () async {
///            await paginateDestination("prev");
///           },
/// ```
/// ### Returns:
///```dart
///  Future
///```
Future paginateDestination(String direction) async {
  int sum = direction == "next" ? 1 : -1;
  if (currentDestination.value + sum >= 0 &&
      currentDestination.value + sum <
          globalctx.memory["destinations"].length) {
    currentDestination.value = currentDestination.value + sum;
    globalDestinationIndex.value = currentDestination.value.toString();
    try {
      globalDestinationName.value = globalctx
          .memory["destinations"][globalDestinationIndex.value]
          .value["destination"];
    } catch (e) {
      globalDestinationName.value = "quito";
    }

    globalDestinationType.value = "tour";

    if (currentDestination.value == 0) {
      globalDestinationType.value = "arrival";
    }
    if (currentDestination.value ==
        globalctx.memory["destinations"].length - 1) {
      globalDestinationType.value = "departure";
    }

    log("currentDestination.value: ${currentDestination.value}");
    filterSuggestedServices();
  } else if (currentDestination.value + sum >
      globalctx.memory["destinations"].length - 1) {
    gotoPage("Resume");
  } else {
    gotoPage("Experiences");
  }
}

/// ## resetAllDestinations
/// *__Method to reset all destination options__*
///
///### Uses:
/// ```dart
///
///      resetAllDestinations();
///
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetAllDestinations() {
  globalctx.reset.value = true;
  resetLeftDays();
  resetMemoryDestinations();
  // updateDraggableDestinations();
  filterDestinations();
  if (cruiseDay.isNotEmpty) {
    autoFillDestination(arrival["description"], 0, "arrival", "0");
    autoFillDestination("galapagos", 1, "arrival", cruiseDay.value);
    autoFillDestination(departure["description"], 2, "departure", "0");
  } else {
    setDestinationState(arrival["description"], 0, "arrival", "selected");
    setDestinationState(departure["description"], 1, "departure", "selected");
  }
}

/// ## resetLeftDays
/// *__Method to reset Destination day variables from memory__*
///
///### Uses:
/// ```dart
///  resetLeftDays()
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetLeftDays() {
  leftAccumulated.value = 0;
  dayleft.value = totalDays.value;
  accumulated.value = 0;
}

/// ## autoFillDestination
/// *__Method to auto fill destination options__*
///
///### Uses:
/// ```dart
///autoFillDestination(arrival["description"], 0, "arrival", "0");
///
/// ```
/// ### Returns:
///```dart
/// void
///```
void autoFillDestination(destination, index, type, days) {
  setFormValue(globalctx.memory["destinations"], index, "explorationDay", days);
  setFormValue(globalctx.memory["destinations"], index, "type", type);
  setFormValue(globalctx.memory["destinations"], index, "index", index);
  setFormValue(
      globalctx.memory["destinations"], index, "destination", destination);
  setFormValue(
      globalctx.memory["destinations"], index, "key_activities", ["SURPRISE"]);
  setFormValue(globalctx.memory["destinations"], index, "travel_rhythm",
      destination == "galapagos" ? "3" : "1");
  setFormValue(globalctx.memory["destinations"], index, "explorationMode",
      destination == "galapagos" ? "1" : "0");
  addDestination(destination);
  processDestinationPromotion(destination, index, type);
  setDestinationState(destination, index, type, "selected");
}

/// ## getDestinationList
/// *__Method to get destination list__*
///
///### Uses:
/// ```dart
///getDestinationList();
///
/// ```
/// ### Returns:
///```dart
/// List
///```
List getDestinationList() {
  List<Widget> destinationlist = [];
  List destinations = destinationsCatalog.toList();

  orderDestination(destinations);
  for (Map item in destinations) {
    List itemList = item.values.toList();
    CatalogDto destination = CatalogDto(itemList);

    destinationlist.add(
      CustomDragableDestination(destination: destination.description!),
    );
  }
  return destinationlist;
}

/// ## orderDestination
/// *__Method to order destinations__*
///
///### Uses:
/// ```dart
///  orderDestination(destinations);
/// ```
///
/// @return void
///
void orderDestination(List destinations) {
  if (arrival.isNotEmpty) {
    destinations.sort((a, b) {
      var arrivalData = toCatalog(filterCatalog(
          "destinations", "description", arrival["description"])[0]);
      var arrivalLat = arrivalData.relation["latitude"];
      var arrivalLong = arrivalData.relation["longitude"];
      var aLat = toCatalog(a).relation["latitude"];
      var bLat = toCatalog(b).relation["latitude"];
      var aLong = toCatalog(a).relation["longitude"];
      var bLong = toCatalog(b).relation["longitude"];
      var bDistance = (getGPSDistance(bLat, bLong, arrivalLat, arrivalLong));
      var aDistance = (getGPSDistance(aLat, aLong, arrivalLat, arrivalLong));
      return aDistance.compareTo(bDistance);
    });
  }
}

/// ## processDestinationPromotion
/// *__Method to promote destination__*
///
///### Uses:
/// ```dart
///  processDestinationPromotion(destination, index, type);
/// ```
///
/// @return void
///
void processDestinationPromotion(destination, index, type) {
  updatePromotedDestination(destination, index);
  setDestinationState(destination, index, type, "promoted");
  updateDraggableDestinations();
  updateTotalLeftAccumulated();
}

/// ## promoteDestination
/// *__Method to promote destination__*
///
///### Uses:
/// ```dart
///   onNext: () {
///                  promoteDestination(ctrl, _formKey, destination, index, type);
///                },
/// ```
///
/// @return void
///
void promoteDestination(ctrl, _formKey, destination, index, type) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    processDestinationPromotion(destination, index, type);
    Get.close(1);
  }
}

/// ## updatePromotedDestination
/// *__Method to update a promoted destination__*
///
///### Uses:
/// ```dart
///   updatePromotedDestination(destination, index);
/// ```
///
/// @return void
///
void updatePromotedDestination(destination, index) {
  if (!globalctx.promotedDestinations.contains(index)) {
    globalctx.promotedDestinations.add(index);
    destinations = globalctx.memory["destinations"];
  }
  arrivalState.value = "selected";
  departureState.value = "selected";
  if (globalctx.promotedDestinations.isNotEmpty) {
    arrivalState.value = "promoted";
  }
}

/// ## updateDraggableDestinations
/// *__Method to update a draggable destinations__*
///
///### Uses:
/// ```dart
///   updateDraggableDestinations();
/// ```
///
/// @return void
///
void updateDraggableDestinations() {
  if (arrivalState.value == "promoted" &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
    destDraggable.value = 1;
  }
  if (arrivalState.value == "promoted" &&
      departureState.value == "promoted" &&
      globalctx.promotedDestinations.length ==
          globalctx.selectedDestinations.length) {
    destDraggable.value = 0;
  }
}

/// ## getCombinedDestinations
/// *__Method to get combined destinations whit memory__*
///
///### Uses:
/// ```dart
///   var destinations = getCombinedDestinations();
/// ```
///
/// @return Map
///
Map getCombinedDestinations() {
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  return destinations;
}

/// ## processDestinations
/// *__Method to update a draggable destinations__*
///
///### Uses:
/// ```dart
///  await processDestinations(context);
/// ```
///
/// @return Future
///
Future processDestinations(context) async {
  // ignore: unrelated_type_equality_checks
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft == 0)) {
    formKey = GlobalKey<FormState>();
    var destinationDay = [];
    experiencePromotedDragData.value = <Widget>[];

    var destinations = getCombinedDestinations();
    int idx = 0;
    for (var destination in destinations.entries.toList()) {
      var dest = destinations[idx.toString()];
      var explorationDay = dest["explorationDay"];
      var days = int.parse(explorationDay);
      destinationDay.add({...dest, "destination": destination, "days": days});
      accDays += days;
      idx++;
    }
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays.value;
    arrival.value = getDestinationById(arrivalPort.value);
    departure.value = getDestinationById(departurePort.value);
    globalDestinationName.value = arrival["description"];
    globalDestinationType.value = "arrival";
    globalDestinationIndex.value = "0";
    currentDay.value = -1;
    await nextDay();
  } else {
    if (context != null) {
      SweetAlertV2.show(context,
          curve: ElasticInCurve(),
          title: (dayleft.value > 0)
              ? "You still have $dayleft days to enjoy, do you want to review the other options we have for you?"
              : "Promote any destination is required",
          style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
    }
  }
}

/// ## addDestination
/// *__Method to add a destination to memory__*
///
///### Uses:
/// ```dart
///  addDestination(destination);
/// ```
///
/// @return void
///
void addDestination(String destination) {
  var newIndex = globalctx.destinations.length - 1;
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.insert(newIndex, destination);
  }

  setDestinationState(destination, newIndex, "tour", "selected");
}

/// ## setDestinationState
/// *__Method to change Destination states__*
///
///### Uses:
/// ```dart
///  setDestinationState(destination, index, type, "promoted");
/// ```
///
/// @return void
///
void setDestinationState(dest, index, type, state) {
  globalctx.states["destinations"][index] ??= {}.obs;
  globalctx.states["destinations"][index]["destination"] = dest;
  globalctx.states["destinations"][index]["index"] = index;
  globalctx.states["destinations"][index]["state"] = state;
  globalctx.states["destinations"][index]["type"] = type;
  if (dest == arrival["description"] && type == "arrival") {
    arrivalState.value = state;
  }
  if (dest == departure["description"] && type == "departure") {
    departureState.value = state;
  }
}

/// ## validateDragDestinationOptions
/// *__Method to validate graphic drag destination options__*
///
///### Uses:
/// ```dart
///  if (isListed ||
///         !validateDragDestinationOptions(destination, index, type).value)
/// ```
///
/// @return RxBool
///
RxBool validateDragDestinationOptions(destination, index, type) {
  bool isArrival = index == 0 && type == "arrival";
  bool isDeparture =
      destination == departure["description"] && type == "departure";
  bool isSelected = getDestinationState(destination, index, type) == "selected";
  bool isPromoted = getDestinationState(destination, index, type) == "promoted";
  bool isArrivalPromoted =
      getDestinationState(arrival["description"], 0, "arrival") == "promoted";
  bool isTour = !isArrival && !isDeparture;
  bool isDayleft = dayleft.value > 0;
  bool basicRule = isSelected && !isPromoted;
  bool arrivalRule = isArrival && basicRule;
  bool tourRule = isTour && basicRule && isArrivalPromoted;
  bool departureRule =
      isDayleft && (isDeparture && basicRule && isArrivalPromoted);

  return ((arrivalRule || tourRule || departureRule)).obs;
}

/// ## filterSelectedDestinations
/// *__Method to filter destinations__*
///
///### Uses:
/// ```dart
///  filterSelectedDestinations();
/// ```
///
/// @return void
///
void filterSelectedDestinations() {
  var galapagos = getFormValue(globalctx.memory, "tour", "galapagos", false);
  if (dayleft.value > 1 &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
    if (selectedDestinations.contains(arrival["description"])) {
      selectedDestinations.remove(arrival["description"]);
    }

    if (selectedDestinations.contains("galapagos") || galapagos) {
      selectedDestinations.remove("galapagos");
    }
    if (selectedDestinations.contains(departure["description"])) {
      selectedDestinations.remove(departure["description"]);
    }
    selectedDestinations.insert(0, arrival["description"]);
    if (galapagos) {
      selectedDestinations.insert(1, "galapagos");
    }
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
      moveGraphDragDestinationOption(selected, idx, type);
      idx++;
    }
  }
}

/// ## moveGraphDragDestinationOption
/// *__Method to move graphic drag destination option__*
///
///### Uses:
/// ```dart
///   moveGraphDragDestinationOption(selected, idx, type);
/// ```
///
/// @return void
///
void moveGraphDragDestinationOption(
    String destination, int index, String type) {
  var state = getDestinationState(destination, index, type);
  setDestinationState(destination, index, type, state);
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value.add(DragDestinationWidget(
      destination: destination, index: index, type: type, out: false));
}

/// ## deleteGraphDragDestinationOption
/// *__Method to delete destinations__*
///
///### Uses:
/// ```dart
///  onTap: () {
///     deleteGraphDragDestinationOption(destination);
///      },
/// ```
///
/// @return void
///
void deleteGraphDragDestinationOption(String destination) {
  if (arrivalPort.value != getDestinationIdByName(destination) &&
      departurePort.value != getDestinationIdByName(destination) &&
      globalctx.destinations.contains(destination)) {
    globalctx.promotedDestinations.remove(destination);
    var index =
        globalctx.destinations.indexWhere((element) => element == destination);
    var type = "tour";
    setDestinationState(destination, index, type, "suggested");
    globalctx.destinations.removeAt(index);
    globalctx.selectedDestinations.removeAt(index);
    globalctx.destinationDragData.value.removeAt(index);
    var destDay = int.parse(getFormValue(globalctx.memory["destinations"],
        index.toString(), "explorationDay", "0"));
    var destinationExists =
        globalctx.memory["destinations"].keys.contains(index.toString());

    if (destinationExists) {
      accumulated -= destDay;
      dayleft += destDay;
    }

    if (destination == "galapagos") {
      iHStartDate = Rx(firstDayDate.value);
      iHEndDate = Rx(penultimateDayDate.value);
      cruiseStartDate = Rx(firstDayDate.value);
      cruiseEndDate = Rx(penultimateDayDate.value);
    }
  }
}

/// ## getDestinationById
/// *__Method to get destination data from id as input__*
///
///### Uses:
/// ```dart
///  arrival.value = getDestinationById(arrivalPort.value);
/// ```
///
/// @return dynamic
///
dynamic getDestinationById(destId) {
  try {
    var dest = destinationsCatalog
        .toList()
        .where((element) => element["code"] == int.parse(destId))
        .first;
    return dest;
  } catch (e) {
    log(e);
  }
}

/// ## getDestinationIdByName
/// *__Method to get destination id from name as input__*
///
///### Uses:
/// ```dart
///  if (arrivalPort.value != getDestinationIdByName(destination) &&
/// ```
///
/// @return dynamic
///
dynamic getDestinationIdByName(String destination) {
  var id = getDestinationByName(destination)["code"].toString();
  return id;
}

/// ## getDestinationValueByName
/// *__Method to get destination value from name as input__*
///
///### Uses:
/// ```dart
///  var destData = getDestinationValueByName(destination);
/// ```
///
/// @return dynamic
///
getDestinationValueByName(String destination) {
  var result = [];
  try {
    result = getDestinationByName(destination)["value"];
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## getDestinationByName
/// *__Method to get destination from name as input__*
///
///### Uses:
/// ```dart
///  var destData = getDestinationByName(destination);
/// ```
///
/// @return dynamic
///
dynamic getDestinationByName(String destination) {
  var result;
  try {
    List<Map<String, dynamic>> list = destinationsCatalog.toList();
    result = list.firstWhere(
        (element) => element["description"].toString() == destination);
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## getDestinationState
/// *__Method to get destination from name as input__*
///
///### Uses:
/// ```dart
///  bool isSelected = getDestinationState(destination, index, type) == "selected";
/// ```
///
/// @return String
///
String getDestinationState(destination, index, type) {
  var state = "suggested";
  globalctx.states["destinations"][index] ??= {}.obs;
  state = globalctx.states["destinations"][index]["state"] ?? "suggested";
  if (globalctx.states["destinations"][index]["type"] != type) {
    return state;
  }
  if (destination == departure["description"] && type == "departure") {
    if (selectedIndex.value == 3) {
      return departureState.value;
    } else {
      return "selected";
    }
  }
  return state;
}

/// ## updateTotalLeftAccumulated
/// *__Method to update destination left days __*
///
///### Uses:
/// ```dart
///  updateTotalLeftAccumulated();
/// ```
///
/// @return void
///
void updateTotalLeftAccumulated() {
  accumulated.value = 0;
  if (destinations.isNotEmpty) {
    for (var destination in destinations.keys) {
      accumulated.value += getDestinationExplorationDay(destination);
    }
  }
  dayleft.value = totalDays.value - accumulated.value;
}

/// ## getMaxTrValue
/// *__Method to get Max Trevel Rhythm __*
///
///### Uses:
/// ```dart
///  updateTotalLeftAccumulated();
/// ```
///
/// @return double
///
double getMaxTrValue(tr) {
  return trMaxValues[tr] as double;
}

/// ## getMaxTrHourValue
/// *__Method to get Travel Rhythm weighted in Hours__*
///
///### Uses:
/// ```dart
///   var max = getMaxTrHourValue(currentTravelRhythm.value);
/// ```
///
/// @return int
///
int getMaxTrHourValue(tr) {
  return trMaxHourValues[tr] as int;
}

/// ## getAgeMaxTrValue
/// *__Method to get Travel Rhythm Age Range__*
///
///### Uses:
/// ```dart
///   var range = getAgeMaxTrValue(e["description"].toString().toUpperCase());
/// ```
///
/// @return List
///
List<int> getAgeMaxTrValue(tr) {
  return trAgeMaxValues[tr] as List<int>;
}

/// ## getDestinationIndex
/// *__Method to get current Destination Index__*
///
///### Uses:
/// ```dart
///   int destIndex = getDestinationIndex(destination, type);
/// ```
///
/// @return int
///
int getDestinationIndex(String destination, String type) {
  int destIndex = 0;
  var destinations = globalctx.states["destinations"].entries;
  for (var e in destinations) {
    if (e.value["destination"] == destination && e.value["type"] == type) {
      destIndex = e.value["index"];
    }
  }
  if (type == "arrival") {
    destIndex = 0;
  }
  if (type == "departure") {
    destIndex = globalctx.promotedDestinations.length - 1;
  }
  return destIndex;
}

/// ## getDestinationIndex
/// *__Method to get current Destination Index__*
///
///### Uses:
/// ```dart
///   int destIndex = getDestinationIndex(destination, type);
/// ```
///
/// @return int
///
getDestinationTravelRhythm(destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  var trData = findCatalog("travel_rhythm").toList();
  var trRange = trData
      .firstWhere((e) => e["code"] == int.parse(destData["travel_rhythm"]));
  return trRange;
}

/// ## getDestinationIndex
/// *__Method to get Destination Key Activies from memory__*
///
///### Uses:
/// ```dart
///   var destKa = getDestinationKa(
///     globalDestinationName.value, globalDestinationType.value);
/// ```
///
/// @return dynamic
///
dynamic getDestinationKa(destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  return destData["key_activities"];
}

/// ## filterDestinations
/// *__Method to filter Dstinations memory__*
///
///### Uses:
/// ```dart
///   filterDestinations();
/// ```
///
/// @return void
///
void filterDestinations() {
  var arr = getDestinationById(arrivalPort.value);
  var dep = getDestinationById(departurePort.value);
  arrival.value = arr;
  departure.value = dep;
  filterSelectedDestinations();
}

/// ## getDestinationExplorationDay
/// *__Method to get Destination Exploration Day memory__*
///
///### Uses:
/// ```dart
///    accumulated.value += getDestinationExplorationDay(destination) as int;
/// ```
///
/// @return void
///
int getDestinationExplorationDay(index) {
  int result = 0;
  index = index.toString();
  if (destinations[index] != null) {
    if (destinations[index]["explorationDay"] != null) {
      result = int.parse(destinations[index]["explorationDay"]);
    }
  }
  return result;
}

/// ## updateCurrentDestination
/// *__Method to update current Destination__*
///
///### Uses:
/// ```dart
///    updateCurrentDestination();
/// ```
///
/// @return void
///
void updateCurrentDestination() {
  var type = "tour";
  if (currentDay.value == 0) {
    type = "arrival";
  }
  if (currentDay.value == totalDays.value - 1) {
    type = "departure";
  }
  currentDestinationType = type;
  globalDestinationType.value = type;
}

/// ## resetMemoryDestinations
/// *__Method to reset all Destinations on memory__*
///
///### Uses:
/// ```dart
///    resetMemoryDestinations();
/// ```
///
/// @return void
///
void resetMemoryDestinations() {
  destDraggable.value = 0;
  allPromotedDestinations.value = [];
  globalctx.promotedDestinations.value = [];
  globalctx.selectedDestinations.value = [];
  globalctx.destinations.value = [];
  globalctx.destinationDragData.value = [];
  globalctx.memory["destinations"] = {};
  globalctx.states["destinations"] = {};
}

/// ## getDestiinationRoutes
/// *__Method to get sub Destinations from a Primary Destination__*
///
///### Uses:
/// ```dart
///     (destination != "galapagos" &&
///                     (getDestiinationRoutes(destination).length > 0))) {
/// ```
///
/// @return List<Map<String, dynamic>>
///
List<Map<String, dynamic>> getDestiinationRoutes(String destination) {
  List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
  try {
    var destData = getDestinationValueByName(destination);
    var subs = destData[9]["subs"];
    if (subs.length > 0) {
      for (var sub in subs) {
        res.add(sub);
      }
    }
  } catch (e) {
    log(e);
  }
  return res;
}

/// ## filterTrByAge
/// *__Method to filter Travel Rythm by Age__*
///
///### Uses:
/// ```dart
///    filterTrByAge();
/// ```
///
/// @return List<Map<String, dynamic>>
///
List<Map<String, dynamic>> filterTrByAge() {
  var tr = findCatalog("travel_rhythm");
  List<Map<String, dynamic>> result = tr.toList();
  var birthDate = globalctx.memory["customer"]["birth_date"];
  var age = DateTime.now().difference(DateTime.parse(birthDate)).inDays / 365;
  result = tr.toList().where((e) {
    var range = getAgeMaxTrValue(e["description"].toString().toUpperCase());
    // var min = range[0];
    var max = range[1];
    var rule2 = age <= max;
    var rule = rule2;
    return rule;
  }).toList();
  return result;
}

/// ## clearCurrentDestinationKeyActivities
/// *__Method to clear Key Activities__*
///
///### Uses:
/// ```dart
///     clearCurrentDestinationKeyActivities();
/// ```
/// ### Returns:
///```dart
/// void
///```
void clearCurrentDestinationKeyActivities() {
  clearedKA[currentDay.value] ??= false;
  if (clearedKA[currentDay.value]) {
    currentDestinationKeyActivities.value = <String>[];
    setFormValue(globalctx.memory["destinations"],
        currentDestinationIndex.value, "key_activities", <String>[]);
  }
}

/// ## getCurrentDestinationMaximumDays
/// *__Method to get current Destination Maiximum days__*
///
///### Uses:
/// ```dart
///       int maxDestDays = getCurrentDestinationMaximumDays();
/// ```
/// ### Returns:
///```dart
///   int
///```
int getCurrentDestinationMaximumDays() {
  updateDestinationDays();
  int maxValue = getListMaxValue(destDays);
  return maxValue;
}

/// ## getCurrentDestinationAccumulatedDaysOff
/// *__Method to get destination accumulates daysoff days__*
///
///### Uses:
/// ```dart
///      int accOff = getCurrentDestinationAccumulatedDaysOff(destId);
/// ```
/// ### Returns:
///```dart
///   int
///```
getCurrentDestinationAccumulatedDaysOff(int destId) {
  int accOff = 0;
  for (int i = 0; i < destId; i++) {
    accOff += daysOff[i] as int;
  }
  return accOff;
}

/// ## getCurrentDestinationDays
/// *__Method to current destination days__*
///
///### Uses:
/// ```dart
///      int currenDestDays = getCurrentDestinationDays(destId);
/// ```
/// ### Returns:
///```dart
///   int
///```
int getCurrentDestinationDays(int destId) {
  updateDestinationDays();
  int result = destDays[destId];
  return result;
}

/// ## updateDestinationDays
/// *__Method to update Destination days__*
///
///### Uses:
/// ```dart
///      updateDestinationDays();
/// ```
/// ### Returns:
///```dart
///   void
///```
void updateDestinationDays() {
  destDays = [];
  for (var dest in globalctx.memory["destinations"].entries) {
    var destDay = dest.value;
    destDays.add(int.parse(destDay["explorationDay"]));
  }
}

/// ## getCurrentDestinationDayId
/// *__Method to get Day Id__*
///
///### Uses:
/// ```dart
///      var dayId = getCurrentDestinationDayId(destId, destDay);
/// ```
/// ### Returns:
///```dart
///   int
///```
int getCurrentDestinationDayId(int destId, int destDay) {
  int maxDestDays = getCurrentDestinationMaximumDays();
  int currenDestDays = getCurrentDestinationDays(destId);
  int currenDestDaysOff = maxDestDays - currenDestDays;
  pushList(daysOff, destId, currenDestDaysOff);
  int accOff = getCurrentDestinationAccumulatedDaysOff(destId);
  int destMatrixIndex = maxDestDays * destId + destDay;
  int dayId = destMatrixIndex - accOff;
  return dayId;
}
