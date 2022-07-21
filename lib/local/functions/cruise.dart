// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/3/logistic/widgets/index.dart';

//  ██████╗██████╗ ██╗   ██╗██╗███████╗███████╗
// ██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝
// ██║     ██████╔╝██║   ██║██║███████╗█████╗
// ██║     ██╔══██╗██║   ██║██║╚════██║██╔══╝
// ╚██████╗██║  ██║╚██████╔╝██║███████║███████╗
//  ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝╚══════╝╚══════╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

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
  if (cruiseDay.value != "0")
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
  if (cruiseDay.value != "0")
    itinerary = itinerary
        .where((element) =>
            element["value"]["days"].toString().toUpperCase() ==
            (cruiseDay.value.toString().toUpperCase()))
        .toList();
  //CRUISE ITINERARY FORMAT
  if (cruiseItinerary.value.isNotEmpty)
    itinerary = itinerary.where((element) {
      var rule = true;
      cruiseItinerary.value.forEach((item) {
        rule = rule ||
            element["value"]["itinerary_format"].toString().toUpperCase() ==
                item.toString().toUpperCase();
      });
      return rule;
    }).toList();

  cruiseResults.value = cruises.toList();
  try {
    var processedData = buildCruiseDataTable(ctx, cruiseResults.value);
    searcherHeader.value = processedData[0];
    searcherDetail.value = processedData[1];
    if (searcherHeader.value.isNotEmpty) {
      cruiseTable.value = (DataTable(
        columns: searcherHeader.value,
        rows: searcherDetail.value,
      ));
    }
  } catch (e) {
    log(e);
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
            fontSize: 15,
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
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 204, 164, 61),
        ).getStyle(),
      ),
    ));
  }

  return header;
}

/// ## cruiseReset
/// *__Method to reset cruise memory variables__*
///
/// ### Uses:
/// ```dart
///  cruiseReset()
/// ```
///
///
void cruiseReset() {}

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
  cruiseCabine.value = [];
  cruiseModality.value = '';
  cruisePax.value = '';
  cruiseTriple.value = '';
  cruiseStarts.value = '';
  cruiseEnds.value = '';
  cruiseIslet.value = '';
}

/// ## buildCruiseDataTable
/// *__Method to build cruise datatable__*
///
///### Uses:
/// ```dart
///  buildCruiseDataTable(context, data);
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
  day = day.replaceAll("[", "");
  day = day.replaceAll("]", "");
  if (day.isNotEmpty) {
    var res = days.firstWhere((element) =>
        element["spa"].toString().toUpperCase() == day.toUpperCase() ||
        element["eng"].toString().toUpperCase() == day.toUpperCase());
    return res;
  }
  return {"dayId": 1};
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
    Obx(() => Row(
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
              icon: const Icon(Icons.event_note_rounded, size: 20),
              tooltip: 'Show Cruise Itinerary',
              onPressed: () {
                showCruiseResultDialog(context,
                    cruiseId: 999, cruiseName: row["description"]);
              },
            ),
            CustomFormCalendarFieldWidget(
                fontSize: 8,
                width: 0.01,
                label: '',
                initialStartDate: getNextCruiseDate(),
                initialEndDate: getNextCruiseDate()
                    .add(Duration(days: int.parse(cruiseDay.value) - 1)),
                minimumDate: arrivalDate.value,
                maximumDate: getNextCruiseDate()
                    .add(Duration(days: int.parse(cruiseDay.value))),
                startEndDateChange: (start, end) {
                  saveCruiseCalendar(start, end);
                },
                onSaved: () {
                  var start = cruiseStartDate.value;
                  var end = cruiseEndDate.value;
                  saveCruiseCalendar(start, end);
                }),
            CheckboxIconFormField(
              padding: 0,
              initialValue: selectedCruise.value == row["description"],
              onChanged: (value) {
                selectedCruise.value = row["description"];
                setFormValue(globalctx.memory, "logistic", "cruiseName",
                    selectedCruise.value);
                var start = cruiseStartDate.value;
                var end = cruiseEndDate.value;
                saveCruiseCalendar(start, end);
              },
            ),
          ],
        )),
  );
  return dataCell;
}

/// ## showCruiseResultDialog
/// *__Method show Cruise Result dialog__*
///
///### Uses:
/// ```dart
///      onPressed: () {
///   showCruiseResultDialog(context,
///       cruiseId: 999, cruiseName: row["description"]);
/// },
/// ```
/// ### Returns:
///```dart
/// void
///```
showCruiseResultDialog(ctx,
    {int cruiseId = 999, String cruiseName = ''}) async {
  var frame = {
    "data": {
      "cruise_id": cruiseId,
      "cruise_name": cruiseName != '' ? cruiseName.split("-")[0] : ''
    },
  };
  var res = await fetchHandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultFindCruise, 'POST', frame);
  // ignore: avoid_print
  log(res);
  if (res['state'] == true) {
    var data = res['data'];
    if (data.length > 0) {
      showCruiseDetailDialog(ctx, data[0]);
    }
  } else {
    SweetAlertV2.show(ctx,
        curve: ElasticInCurve(),
        title: res['message'],
        style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
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
