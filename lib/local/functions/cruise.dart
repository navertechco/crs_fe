// ignore_for_file: prefer_function_declarations_over_variables
// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/3/logistic/widgets/index.dart';

/// ## getCruiseItinerary
/// *__Method to get the cruise itinerary from a gived extracted cruise registry from memory__*
///
///### Uses:
/// ```dart
/// Text(
///       "${getCruiseItinerary(row)}",.....
/// ```
///
/// @return itinerary (String)
///
String getCruiseItinerary(row) {
  var itinerary = row["cruise_itinerary"]
      .toString()
      .replaceAll("[", '')
      .replaceAll("]", '');
  var itineraryList = itinerary.split(",");
  var result = '';
  var i = 1;
  for (var item in itineraryList) {
    if (item.toString() != '') {
      result +=
          "${getCatalogDescription(findCatalog("week_day"), i)}: ${item.toString()} \n";
    }

    if (i == 7) {
      i = 1;
    } else {
      i++;
    }
  }
  return result;
}

/// ## filterCruises
/// *__Method to filter cruise catalogs__*
///
///### Uses:
/// ```dart
///  filterCruises(context);
/// ```
///
/// @return void
///
void filterCruises(ctx) {
  cruises = findCatalog("cruises");
  cabine = findCatalog("cabine");
  itinerary = findCatalog("itinerary");
  animals = findCatalog("animals");
  //CRUISE CATEGORY LUJO / PRIMERA
  if (cruiseCategory.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_category"]
            .toString()
            .toUpperCase()
            .contains(cruiseCategory.value))
        .toList();
  //CRUISE TYPE
  if (cruiseType.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_type"]
            .toString()
            .toUpperCase()
            .contains(cruiseType.value))
        .toList();
  //CRUISE MODALITY CATAMARAN / MONOCASCO / YATE
  if (cruiseModality.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["modality"]
            .toString()
            .toUpperCase()
            .contains(cruiseModality.value))
        .toList();
  //CRUISE PORT BAQUERIZO / AYORA
  if (cruisePort.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_port"]
            .toString()
            .toUpperCase()
            .contains(cruisePort.value.toString().toUpperCase()))
        .toList();
  //CRUISE DURATION
  if (cruiseDay.isNotEmpty)
    cabine = cabine
        .where((element) =>
            element["value"]["days"].toString().toUpperCase() ==
            (cruiseDay.value.toString().toUpperCase()))
        .toList();
  //CRUISE CABINE
  if (cruiseCabine.isNotEmpty)
    cabine = cabine
        .where((element) =>
            element["value"]["cabine_type"].toString().toUpperCase() ==
            (cruiseCabine.value.toString().toUpperCase()))
        .toList();
  //CRUISE ANIMALS
  if (cruiseAnimal.isNotEmpty)
    animals = animals
        .where((element) =>
            element["description"].toString().toUpperCase() ==
            (cruiseAnimal.value.toString().toUpperCase()))
        .toList();
  //CRUISE ITINERARY
  if (cruiseDay.isNotEmpty)
    itinerary = itinerary
        .where((element) =>
            element["value"]["days"].toString().toUpperCase() ==
            (cruiseDay.value.toString().toUpperCase()))
        .toList();
  //CRUISE ITINERARY FORMAT
  if (cruiseItinerary.isNotEmpty)
    itinerary = itinerary
        .where((element) =>
            element["value"]["itinerary_format"].toString().toUpperCase() ==
            (cruiseItinerary.value.toString().toUpperCase()))
        .toList();

  cruiseResults.value = cruises.toList();

  var processedData = buildCruiseDataTable(ctx, cruiseResults.value);
  searcherHeader.value = processedData[0];
  searcherDetail.value = processedData[1];
  if (searcherHeader.value.isNotEmpty) {
    cruiseTable.value = (DataTable(
      columns: searcherHeader.value,
      rows: searcherDetail.value,
    ));
  }
}

/// ## getCruiseHeader
/// *__Method to get Filtered Cruise DataColumn to build DataTable__*
///
///### Uses:
/// ```dart
///  var header = getCruiseHeader(context, data, columns);
/// ```
///
/// @return List<DataColumn>
///
List<DataColumn> getCruiseHeader(context, data, columns) {
  var header = <DataColumn>[];
  List cols = [];

  if (data.isNotEmpty) {
    cols = data[0].keys.toList();
    if (columns != null) {
      cols = columns;
    }
    for (int i = 0; i < cols.length; i++) {
      header.add(DataColumn(
        label: Text(
          '',
          textAlign: TextAlign.left,
          style: KTextSytle(
            context: context,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 204, 164, 61),
          ).getStyle(),
        ),
      ));
    }
    header.add(DataColumn(
      label: Text(
        '',
        style: KTextSytle(
          context: context,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 204, 164, 61),
        ).getStyle(),
      ),
    ));
  }

  return header;
}

/// ## clearCruiseFilter
/// *__Method to reset cruise variables__*
///
///### Uses:
/// ```dart
///  clearCruiseFilter();
/// ```
///
/// @return void
///
void clearCruiseFilter() {
  cruiseFormat.value = '';
  cruiseDay.value = '';
  cruiseShip.value = '';
  cruiseRange.value = '';
  cruiseCategory.value = '';
  cruiseKey.value = '';
  cruiseType.value = '';
  cruiseCabine.value = '';
  cruiseModality.value = '';
  cruisePax.value = '';
  cruiseTriple.value = '';
  cruiseStarts.value = '';
  cruiseEnds.value = '';
  cruiseIslet.value = '';
}

/// ## clearCruiseFilter
/// *__Method to build cruise datatable__*
///
///### Uses:
/// ```dart
///  clearCruiseFilter();
/// ```
///
/// @return [List<DataColumn>, List<DataRow>]
///
List buildCruiseDataTable(context, data) {
  var columns = ["description"];
  var header = getCruiseHeader(context, data, columns);
  var detail = getCruiseDetail(context, data, columns);
  return [header, detail];
}

/// ## getCruiseDetail
/// *__Method to get cruise DataRow to build a cruise DataTable__*
///
///### Uses:
/// ```dart
///  var detail = getCruiseDetail(context, data, columns);
/// ```
/// ### Returns:
///```dart
/// List<DataRow>
///```
List<DataRow> getCruiseDetail(context, data, columns) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
        if (key == "description") {
          row[key] = row[key].split("-")[0];
        }
        cells.add(DataCell(Text('${row[key]}',
            textAlign: TextAlign.left,
            style: KTextSytle(
                    context: context,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }

      cells.add(
        getCruiseDataCell(context, row),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

/// ## getNextCruiseDate
/// *__Method to get next day gived a cruise itinerary__*
///
///### Uses:
/// ```dart
///  initialStartDate: getNextCruiseDate(),
/// ```
/// ### Returns:
///```dart
/// DateTime
///```
DateTime getNextCruiseDate() {
  var dayName =
      cruiseItinerary.value.toString().split("-")[0].replaceAll(" ", '');
  var nextCruiseDate = getNextOnCurrentDate(dayName);
  return nextCruiseDate;
}

/// ## getNextOnCurrentDate
/// *__Method to get next week day DateTime gived a dayName__*
///
///### Uses:
/// ```dart
///  var nextCruiseDate = getNextOnCurrentDate(dayName);
/// ```
/// ### Returns:
///```dart
/// DateTime
///```
DateTime getNextOnCurrentDate(dayName) {
  var now = arrivalDate.value;
  var dayId = getDay(dayName)["dayId"] as int;
  var firstOfMonth = DateTime(now.year, now.month, 1);
  var firstMonday = firstOfMonth
      .add(Duration(days: (7 - (firstOfMonth.weekday - DateTime.monday)) % 7));
  var firstDay = firstMonday.add(Duration(days: (dayId - 1)));
  if (now.difference(firstDay).inDays > 0) {
    var mod = 7 * ((now.day / firstDay.day).round() - 1);
    firstDay = firstDay.add(Duration(days: mod));
  }

  return firstDay;
}

/// ## getDay
/// *__Method to get filtered day registry from days catalog__*
///
///### Uses:
/// ```dart
///   var dayId = getDay(dayName)["dayId"] as int;
/// ```
/// ### Returns:
///```dart
/// Map<String, Object>
///```
Map<String, Object> getDay(day) {
  var res = days.firstWhere((element) =>
      element["spa"].toString().toUpperCase() == day.toUpperCase() ||
      element["eng"].toString().toUpperCase() == day.toUpperCase());
  return res;
}

/// ## getCruiseDataCell
/// *__Method to populate a DataCell gived a cruise registry__*
///
///### Uses:
/// ```dart
///  cells.add(
///        getCruiseDataCell(context, row),
///      );
/// ```
/// ### Returns:
///```dart
/// DataCell
///```
DataCell getCruiseDataCell(context, row) {
  var dataCell = DataCell(
    Row(
      children: [
        IconButton(
          padding: EdgeInsets.all(0),
          icon: const Icon(Icons.event_note_rounded, size: 20),
          tooltip: 'Show Cruise Itinerary',
          onPressed: () {
            getCruise(context, cruiseId: 999, cruiseName: row["description"]);
          },
        ),
        Obx(
          () {
            return CustomFormCalendarFieldWidget(
                width: 0.01,
                label: '',
                initialStartDate: getNextCruiseDate(),
                initialEndDate: getNextCruiseDate()
                    .add(Duration(days: int.parse(cruiseDay.value) - 1)),
                minimumDate: arrivalDate.value,
                maximumDate: getNextCruiseDate()
                    .add(Duration(days: int.parse(cruiseDay.value))),
                startEndDateChange: (start, end) {
                  cruiseStartDate.value = start;
                  cruiseEndDate.value = end;
                  if (cruiseStartDate.value
                          .difference(arrivalDate.value)
                          .inDays <=
                      0) {
                    arrivalDate.value =
                        cruiseStartDate.value.add(Duration(days: -1));
                  }
                  departureDate.value = end.add(Duration(days: 1));
                },
                onSaved: () {
                  var start = cruiseStartDate.value;
                  var end = cruiseEndDate.value;
                  if (cruiseStartDate.value
                          .difference(arrivalDate.value)
                          .inDays <=
                      0) {
                    arrivalDate.value =
                        cruiseStartDate.value.add(Duration(days: -1));
                  }
                  departureDate.value = end.add(Duration(days: 1));
                  setFormValue(globalctx.memory["destinations"], 1,
                      "cruiseStartDate", start);
                  setFormValue(globalctx.memory["destinations"], 1,
                      "cruiseEndDate", end);

                  var val1 = cruiseEndDate.value
                          .difference(cruiseStartDate.value)
                          .inDays +
                      1;
                  var val0 = int.parse(getFormValue(
                      globalctx.memory["destinations"],
                      1,
                      "cruiseExpDays",
                      "0"));

                  saveExplorationDay(1, val0, val1, key: "cruiseExpDays");
                });
          },
        ),
        Obx(() => CheckboxIconFormField(
              padding: 0,
              initialValue: selectedCruise.value == row["description"],
              onChanged: (value) {
                selectedCruise.value = row["description"];
                setFormValue(globalctx.memory, "logistic", "cruiseName",
                    selectedCruise.value);
              },
            )),
      ],
    ),
  );
  return dataCell;
}

/// ## showCruiseDetailDialog
/// *__Method to show a cruise detail dialog__*
///
///### Uses:
/// ```dart
///  if (data.length > 0) {
///      showCruiseDetailDialog(ctx, data[0]);
///    }
/// ```
/// ### Returns:
///```dart
/// void
///```
void showCruiseDetailDialog(context, row) {
  showCustomDialog(
    context,
    CruiseDetailWidget(row: row),
    "Close",
    backgroundColor: Color.fromARGB(100, 0, 0, 0),
  );
}
