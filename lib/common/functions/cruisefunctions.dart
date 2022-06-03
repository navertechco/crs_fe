// ignore_for_file: prefer_function_declarations_over_variables
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../index.dart';

Rx<Iterable> cruiseResults = Rx([]);
processCruiseItinerary(row) {
  var itinerary = row["cruise_itinerary"]
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "");
  var itineraryList = itinerary.split(",");
  var result = "";
  var i = 1;
  for (var item in itineraryList) {
    if (item.toString() != "") {
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

List cruises = findCatalog("cruises");
List cabine = findCatalog("cabine");
List itinerary = findCatalog("itinerary");
List animals = findCatalog("animals");

filterCruises(ctx) {
  cruises = findCatalog("cruises");
  cabine = findCatalog("cabine");
  itinerary = findCatalog("itinerary");
  animals = findCatalog("animals");
  //CRUISE CATEGORY LUJO / PRIMERA
  if (cruiseCategory.value.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_category"]
            .toString()
            .toUpperCase()
            .contains(cruiseCategory.value))
        .toList();
  //CRUISE TYPE
  if (cruiseType.value.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_type"]
            .toString()
            .toUpperCase()
            .contains(cruiseType.value))
        .toList();
  //CRUISE MODALITY CATAMARAN / MONOCASCO / YATE
  if (cruiseModality.value.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["modality"]
            .toString()
            .toUpperCase()
            .contains(cruiseModality.value))
        .toList();
  //CRUISE PORT BAQUERIZO / AYORA
  if (cruisePort.value.isNotEmpty)
    cruises = cruises
        .where((element) => element["value"]["cruise_port"]
            .toString()
            .toUpperCase()
            .contains(cruisePort.value.toString().toUpperCase()))
        .toList();
  //CRUISE DURATION
  if (cruiseDay.value.isNotEmpty)
    cabine = cabine
        .where((element) =>
            element["value"]["days"].toString().toUpperCase() ==
            (cruiseDay.value.toString().toUpperCase()))
        .toList();
  //CRUISE CABINE
  if (cruiseCabine.value.isNotEmpty)
    cabine = cabine
        .where((element) =>
            element["value"]["cabine_type"].toString().toUpperCase() ==
            (cruiseCabine.value.toString().toUpperCase()))
        .toList();
  //CRUISE ANIMALS
  if (cruiseAnimal.value.isNotEmpty)
    animals = animals
        .where((element) =>
            element["description"].toString().toUpperCase() ==
            (cruiseAnimal.value.toString().toUpperCase()))
        .toList();
  //CRUISE ITINERARY
  if (cruiseDay.value.isNotEmpty)
    itinerary = itinerary
        .where((element) =>
            element["value"]["days"].toString().toUpperCase() ==
            (cruiseDay.value.toString().toUpperCase()))
        .toList();
  //CRUISE ITINERARY FORMAT
  if (cruiseItinerary.value.isNotEmpty)
    itinerary = itinerary
        .where((element) =>
            element["value"]["itinerary_format"].toString().toUpperCase() ==
            (cruiseItinerary.value.toString().toUpperCase()))
        .toList();

  cruiseResults.value = cruises.toList();

  var processedData = processCruiseData(ctx, cruiseResults.value);
  searcherHeader.value = processedData[0];
  searcherDetail.value = processedData[1];
  if (searcherHeader.value.isNotEmpty) {
    cruiseTable.value = (DataTable(
      columns: searcherHeader.value,
      rows: searcherDetail.value,
    ));
  }
}

getCruiseHeader(context, data, columns) {
  var header = <DataColumn>[];
  List cols = [];

  if (data.isNotEmpty) {
    cols = data[0].keys.toList();
    if (columns != null) {
      cols = columns;
    }
    for (var key in cols) {
      String title = key ?? "";
      header.add(DataColumn(
        label: Text(
          "",
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

clearCruiseFilter() {
  cruiseFormat.value = "";
  cruiseDay.value = "";
  cruiseShip.value = "";
  cruiseRange.value = "";
  cruiseCategory.value = "";
  cruiseKey.value = "";
  cruiseType.value = "";
  cruiseCabine.value = "";
  cruiseModality.value = "";
  cruisePax.value = "";
  cruiseTriple.value = "";
  cruiseStarts.value = "";
  cruiseEnds.value = "";
  cruiseIslet.value = "";
}

processCruiseData(context, data) {
  var columns = ["description"];
  var header = getCruiseHeader(context, data, columns);
  var detail = getCruiseDetail(context, data, columns);
  return [header, detail];
}

getCruiseDetail(context, data, columns) {
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
        getCruisDataCell(context, row),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

var selectedCruise = "".obs;

var days = [
  {"dayId": 1, "spa": "Lunes", "eng": "Monday"},
  {"dayId": 2, "spa": "Martes", "eng": "Tuesday"},
  {"dayId": 3, "spa": "Miercoles", "eng": "Wednesday"},
  {"dayId": 4, "spa": "Jueves", "eng": "Thursday"},
  {"dayId": 5, "spa": "Viernes", "eng": "Friday"},
  {"dayId": 6, "spa": "Sabado", "eng": "Saturday"},
  {"dayId": 7, "spa": "Domingo", "eng": "Sunday"}
];

getDay(day) {
  var res = days.firstWhere((element) =>
      element["spa"].toString().toUpperCase() == day.toUpperCase() ||
      element["eng"].toString().toUpperCase() == day.toUpperCase());
  return res;
}

getNextOnCurrentDate(dayName) {
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

getNextCruiseDate() {
  var dayName =
      cruiseItinerary.value.toString().split("-")[0].replaceAll(" ", "");
  var nextCruiseDate = getNextOnCurrentDate(dayName);
  return nextCruiseDate;
}

getCruisDataCell(context, row) {
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
                label: "",
                initialStartDate: getNextCruiseDate(),
                initialEndDate: getNextCruiseDate()
                    .add(Duration(days: int.parse(cruiseDay.value) - 1)),
                minimumDate: arrivalDate.value,
                maximumDate: departureDate.value
                    .add(Duration(days: int.parse(cruiseDay.value))),
                startEndDateChange: (start, end) {
                  cruiseStartDate.value = start;
                  cruiseEndDate.value = end;
                  arrivalDate.value = start.add(Duration(days: -1));
                  departureDate.value = end.add(Duration(days: 1));
                  cruiseDay.value = (cruiseEndDate.value
                              .difference(cruiseStartDate.value)
                              .inDays +
                          1)
                      .toString();
                },
                onSaved: () {
                  var start = cruiseStartDate.value;
                  var end = cruiseEndDate.value;
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
                  departureDate.value =
                      cruiseEndDate.value.add(Duration(days: 1));
                  saveExplorationDays(1, val0, val1, key: "cruiseExpDays");
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

showCruiseDetail(context, row) {
  showCustomDialog(
    context,
    SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "${row['cruise_name']}",
            style: KTextSytle(
              context: context,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 204, 164, 61),
            ).getStyle(),
          ),
          Image.network(
            "${row['image']}",
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Text(
            "${processCruiseItinerary(row)}",
            style: KTextSytle(
              context: context,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ).getStyle(),
          ),
          Obx(() {
            try {
              return SfCalendar(
                firstDayOfWeek: 1,
                backgroundColor: Colors.white,
                minDate: arrivalDate.value.add(Duration(days: 1)),
                maxDate: departureDate.value.add(Duration(days: -1)),
                view: CalendarView.month,
                dataSource: MeetingDataSource(getDataSource(
                    "${row['cruise_itinerary']}"
                        .replaceAll("[", " ")
                        .replaceAll("]", " "))),
                monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              );
            } catch (e) {
              log(e);
              return Text(
                "No Calendar Aivalable",
                style: KTextSytle(
                  context: context,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 204, 164, 61),
                ).getStyle(),
              );
            }
          })
        ],
      ),
    ),
    "Close",
    backgroundColor: Color.fromARGB(100, 0, 0, 0),
  );
}
