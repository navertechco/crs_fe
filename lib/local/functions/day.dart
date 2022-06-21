//  Functions
// ignore_for_file: prefer_function_declarations_over_variables
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/widgets/index.dart';
import 'package:naver_crs/index.dart';
import 'general.dart';

// ██████╗  █████╗ ██╗   ██╗                                                 
// ██╔══██╗██╔══██╗╚██╗ ██╔╝                                                 
// ██║  ██║███████║ ╚████╔╝                                                  
// ██║  ██║██╔══██║  ╚██╔╝                                                   
// ██████╔╝██║  ██║   ██║                                                    
// ╚═════╝ ╚═╝  ╚═╝   ╚═╝                                                    
                                                                          
// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## paginateDay
/// *__Method to paginate a day__*
///
///### Uses:
/// ```dart
///  if (formKey.currentState!.validate()) {
///                      await paginateDay(context);
///                    }
/// ```

Future paginateDay(context) async {
  if (globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"][currentDay.value] != null) {
    await nextDay();
  } else {
    showCustomDialog(
        context, LeftWidget(destination: "quito", index: 0), "Close");
  }
}

/// ## nextDay
/// *__Method to paginate a day__*
///
///### Uses:
/// ```dart
///  await nextDay();
///
/// ```
/// ### Returns:
///```dart
/// void
///```
Future nextDay() async {
  if (currentDay.value < totalDays.value - 1) {
    jumpDay("forward");
  } else {
    gotoPage("Resume");
  }
}

/// ## jumpDay
/// *__Method to jump over a day__*
///
///### Uses:
/// ```dart
///  jumpDay("forward");
/// ```
/// ### Returns:
///```dart
/// void
///```
Future jumpDay(direction) async {
  decideBypass(direction);
  expDraggable.value = 1;
  currentDate.value =
      arrivalDate.value.add(Duration(days: currentDay.value - 1));
  updateCurrentDestination();
  // promoteMealExperineces();
  filterSuggestedExperiences();
  initializeHours();
  gotoPage("Experiences");
}

/// ## decideBypass
/// *__Method to decide if bypass a day__*
///
///### Uses:
/// ```dart
///  decideBypass("forward");
/// ```
/// ### Returns:
///```dart
/// void
///```
decideBypass(direction) {
  int index = getDestinationIndexByDay();
  int explorationMode = int.parse(getFormValue(
      globalctx.memory["destinations"], index, "explorationMode", "0"));
  var explorationDay = getCurrentExplorationDay();
  var keyActivities = getCurrentKA();
  if (explorationMode > 0) {
    bypassCruise(direction);
  } else if (keyActivities.contains("hh")) {
    bypassDay(direction, explorationDay);
  } else {
    updateCurrentDay(direction);
  }
}

/// ## getDestinationIndexByDay
/// *__Method to get a destination index from memory__*
///
///### Uses:
/// ```dart
///  int index = getDestinationIndexByDay();
/// ```
/// ### Returns:
///```dart
/// int
///```
getDestinationIndexByDay() {
  var _accumulated = 0;
  var _destinations = globalctx.memory["destinations"];

  if (currentDay.value <= 0) {
    return 0;
  }
  var lenght = _destinations.length;
  for (var i = 0; i < lenght; i++) {
    var _dest = _destinations[i.toString()];
    var _explorationDay = int.parse(_dest["explorationDay"]);
    _accumulated += _explorationDay;
    if (currentDay.value < _accumulated ||
        _accumulated - currentDay.value == 0) {
      return i;
    }
  }
}

/// ## getCurrentExplorationDay
/// *__Method to get the current eplorationDay gived a destination index from memory__*
///
///### Uses:
/// ```dart
///  var explorationDay = getCurrentExplorationDay();
/// ```
/// ### Returns:
///```dart
/// int
///```
getCurrentExplorationDay() {
  int index = getDestinationIndexByDay();
  int explorationDay = int.parse(getFormValue(
      globalctx.memory["destinations"], index, "explorationDay", "0"));
  return explorationDay;
}

/// ## getCurrentKA
/// *__Method to get the current Key Activities gived a destination index from memory__*
///
///### Uses:
/// ```dart
///  var explorationDay = getCurrentExplorationDay();
/// ```
/// ### Returns:
///```dart
/// int
///```
getCurrentKA() {
  int index = getDestinationIndexByDay();
  List keyActivities = (getFormValue(
      globalctx.memory["destinations"], index, "key_activities", []));
  return keyActivities;
}

/// ## bypassDay
/// *__Method to increase or decrease the currentDay.value__*
///
///### Uses:
/// ```dart
///  bypassDay(direction, explorationDay);
/// ```
/// ### Returns:
///```dart
/// void
///```
bypassDay(direction, int explorationDay) {
  if (direction == "forward") {
    currentDay.value += explorationDay;
  } else {
    currentDay.value -= explorationDay;
  }
}

/// ## bypassCruise
/// *__Method to bypass a day if it's a cruise day__*
///
///### Uses:
/// ```dart
///  bypassCruise(direction);
/// ```
/// ### Returns:
///```dart
/// void
///```
bypassCruise(String direction) {
  try {
    int index = getDestinationIndex(globalDestinationName.value, "tour");
    int explorationMode = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "explorationMode", "0"));
    int explorationDay = 0;
    int cruiseExpDays = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "cruiseExpDays", "0"));
    if (cruiseExpDays > 0) {
      if (explorationMode > 1) {
        DateTime cruiseStartDate = getFormValue(
            globalctx.memory["destinations"],
            index,
            "cruiseStartDate",
            DateTime(5555, 02, 02));
        DateTime cruiseEndDate = getFormValue(globalctx.memory["destinations"],
            index, "cruiseEndDate", DateTime(5555, 02, 02));

        if (direction == "forward") {
          if (currentDate.value ==
              cruiseStartDate.subtract(Duration(days: 1))) {
            explorationDay = cruiseExpDays;
            currentDay.value += explorationDay;
          }
        } else {
          if (currentDate.value == cruiseEndDate.add(Duration(days: 1))) {
            explorationDay = cruiseExpDays;
            currentDay.value -= explorationDay;
          }
        }
      }
    } else {
      updateCurrentDay(direction);
    }
  } catch (e) {
    log(e);
  }
}

/// ## updateCurrentDay
/// *__Method to increase or decrease the currentDay.value__*
///
///### Uses:
/// ```dart
///  updateCurrentDay(direction);
/// ```
/// ### Returns:
///```dart
/// void
///```
updateCurrentDay(direction) {
  if (direction == "forward") {
    currentDay.value++;
  } else {
    currentDay.value--;
  }
}

/// ## previousDay
/// *__Method to paginate to a prevoius day__*
///
///### Uses:
/// ```dart
///  previousDay()
/// ```
/// ### Returns:
///```dart
/// void
///```
previousDay() {
  if (currentDay.value > 0) {
    jumpDay("backward");
  } else {
    gotoPage("Destination");
  }
}

/// ## processDays
/// *__Method to process all days edited on memory__*
///
///### Uses:
/// ```dart
///  processDays()
/// ```
/// ### Returns:
///```dart
/// void
///```
processDays() {
  result = [];

  for (String dest in destinations.keys.toList()) {
    for (int i = 1; i <= int.parse(destinations[dest]["explorationDay"]); i++) {
      result.add({"day": i, "destination": destinations[dest]["destination"]});
    }
  }

  if (result.isNotEmpty) {
    globalDestinationName.value = result[currentDay.value]["destination"];
    clearedHours[currentDay.value] ??= false;
    clearedKA[currentDay.value] ??= false;
    if (!clearedHours[currentDay.value]) {
      updateCurrentDestinationTravelRhythm();
    }
    if (!clearedKA[currentDay.value]) {
      updateCurrentKeyActivities();
    }
  }
}

/// ## updateCurrentKeyActivities
/// *__Method to current KA from current Day Destination__*
///
///### Uses:
/// ```dart
///  updateCurrentKeyActivities()
/// ```
/// ### Returns:
///```dart
/// void
///```
updateCurrentKeyActivities() {
  var index = getDestinationIndexByDay();
  var ka = getFormValue(
      globalctx.memory["destinations"], index, "key_activities", []);
  currentDestinationKeyActivities.value = ka;
}

/// ## updateCurrentDestinationOption
/// *__Method to current DestOption from current Day Destination__*
///
///### Uses:
/// ```dart
///  updateCurrentDestinationOption()
/// ```
/// ### Returns:
///```dart
/// void
///```
updateCurrentDestinationOption() {
  var index = getDestinationIndexByDay();
  var destinationOption = getFormValue(
      globalctx.memory["destinations"], index, "destination_option", "1");
  currentDestinationOption.value = destinationOption;
}

/// ## updateCurrentDestinationTravelRhythm
/// *__Method to current TR from current Day Destination__*
///
///### Uses:
/// ```dart
///  updateCurrentDestinationTravelRhythm()
/// ```
/// ### Returns:
///```dart
/// void
///```
updateCurrentDestinationTravelRhythm() {
  var index = getDestinationIndexByDay();
  var travelRhythm = getFormValue(
      globalctx.memory["destinations"], index, "travel_rhythm", "1");
  currentTravelRhythm.value = travelRhythm;
}

/// ## saveExplorationDay
/// *__Method to save ExplorationDay to memory__*
///
///### Uses:
/// ```dart
///    saveExplorationDay(1, val0, val1, key: "cruiseExpDays");
/// ```
/// ### Returns:
///```dart
/// void
///```
void saveExplorationDay(int index, int val0, int val1, {String? key}) {
  try {
    int acc0 = accumulated.value;
    int td = totalDays.value;
    int total0 = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "explorationDay", "0"));
    int nei0 = total0 - val0;
    if (total0 == 0 || nei0 < 0) {
      nei0 = 0;
    }

    if (acc0 < td) {
      int nei1 = nei0;
      int total1 = nei1 + val1;
      int acc1 = total1 - nei0 - val0 + acc0;
      int dl1 = td - acc1;

      dayleft.value = dl1;
      accumulated.value = acc1;
      if (key != null) {
        setFormValue(
            globalctx.memory["destinations"], index, key, val1.toString());
      }

      setFormValue(globalctx.memory["destinations"], index, "explorationDay",
          (total1).toString());
      if (index == 0) {
        firstDayDate = Rx(arrivalDate.value.add(Duration(days: acc1)));
      }
    }
  } catch (e) {
    log(e);
  }
}

/// ## parseHour
/// *__Method to parse a Hour String__*
///
///### Uses:
/// ```dart
///    var closeTime = parseHour(e.value["closeTime"]);
/// ```
/// ### Returns:
///```dart
/// int
///```
int parseHour(str) {
  if (str.contains("h")) {
    var parts = str.split("h");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  } else if (str.contains(":")) {
    var parts = str.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  } else {
    return int.parse(str);
  }
}
