// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../index.dart';

Rx<Iterable> cruiseResults = Rx([]);
Function processCruiseItinerary = (row) {
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
};

Function filterCruises = (ctx) {
  if (globalctx.memory["cruises"] != null) {
    List filtered = globalctx.memory["cruises"];

    List filterByCategory = filtered
        .where((element) => element["cruise_category"]
            .toString()
            .toUpperCase()
            .contains(cruiseCategory.value))
        .toList();
    List filterByKey = filterByCategory
        .where((element) => element["cruise_itinerary"]
            .toString()
            .toUpperCase()
            .contains(cruiseKey.value))
        .toList();
    List filterByType = filterByKey
        .where((element) => element["cruise_type"]
            .toString()
            .toUpperCase()
            .contains(cruiseType.value))
        .toList();
    List filterByModality = filterByType
        .where((element) => element["modality"]
            .toString()
            .toUpperCase()
            .contains(cruiseModality.value))
        .toList();
    List filterByArrival = filterByModality
        .where((element) => element["cruise_format"]
            .toString()
            .toUpperCase()
            .contains(cruiseStarts.value.toString().toUpperCase()))
        .toList();
    List filterByDeparture = filterByArrival
        .where((element) => element["cruise_format"]
            .toString()
            .toUpperCase()
            .contains(cruiseEnds.value.toString().toUpperCase()))
        .toList();
    List filterByIslet = filterByDeparture
        .where((element) => element["cruise_itinerary"]
            .toString()
            .toUpperCase()
            .contains(cruiseIslet.value.toString().toUpperCase()))
        .toList();
    List filterByDays = filterByIslet.where((element) => true).toList();
    List filterByDay = filterByDays.where((element) => true).toList();
    List filterByCruise = filterByDay.where((element) => true).toList();
    List filterByDateRange = filterByCruise.where((element) => true).toList();
    List filterByCabine = filterByDateRange.where((element) => true).toList();
    List filterByTriple = filterByCabine.where((element) => true).toList();

    cruiseResults.value = filterByTriple.toList();

    var processedData = processCruiseData(ctx, cruiseResults.value, columns);
    searcherHeader.value = processedData[0];
    searcherDetail.value = processedData[1];

    cruiseTable.value = DataTable(
      columns: searcherHeader.value,
      rows: searcherDetail.value,
    );
  }
};

Function getCruiseDetail = (context, data, columns) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
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
};

getCruisDataCell(context, row) {
  var dataCell = DataCell(
    IconButton(
      padding: EdgeInsets.all(0),
      icon: const Icon(Icons.event_note_rounded, size: 20),
      tooltip: 'Show Cruise Itinerary',
      onPressed: () {
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
      },
    ),
  );
  return dataCell;
}
