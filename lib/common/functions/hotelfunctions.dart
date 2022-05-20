// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../index.dart';

Rx<Iterable> hotelResults = Rx([]);
processHotelItinerary(row) {
  var itinerary =
      row["hotel_itinerary"].toString().replaceAll("[", "").replaceAll("]", "");
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

filterHotels(ctx) {
  if (globalctx.memory["hotels"] != null) {
    List filtered = globalctx.memory["hotels"];

    List filterByDays = filtered.where((element) => true).toList();
    List filterByDay = filterByDays.where((element) => true).toList();
    List filterByHotel = filterByDay.where((element) => true).toList();
    List filterByDateRange = filterByHotel.where((element) => true).toList();
    List filterByCabine = filterByDateRange.where((element) => true).toList();
    List filterByTriple = filterByCabine.where((element) => true).toList();

    hotelResults.value = filterByTriple.toList();

    var processedData = processHotelData(ctx, hotelResults.value);
    searcherHeader.value = processedData[0];
    searcherDetail.value = processedData[1];
    if (searcherHeader.value.isNotEmpty) {
      hotelTable.value = (DataTable(
        columns: searcherHeader.value,
        rows: searcherDetail.value,
      ));
    }
  }
}

getHotelHeader(context, data, columns) {
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

processHotelData(context, data) {
  var columns = ["description"];
  var header = getHotelHeader(context, data, columns);
  var detail = getHotelDetail(context, data, columns);
  return [header, detail];
}

getHotelDetail(context, data, columns) {
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
        getHotelDataCell(context, row),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

getHotelDataCell(context, row) {
  var dataCell = DataCell(
    IconButton(
      padding: EdgeInsets.all(0),
      icon: const Icon(Icons.event_note_rounded, size: 20),
      tooltip: 'Show Hotel Itinerary',
      onPressed: () {
        showCustomDialog(
          context,
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "${row['description']}",
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
                  "${processHotelItinerary(row)}",
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
                          "${row['hotel_itinerary']}"
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
