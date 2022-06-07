// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

processQuoteHistoryItinerary(row) {
  var itinerary =
      row["quote_itinerary"].toString().replaceAll("[", '').replaceAll("]", '');
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

filterQuoteHistory(ctx) {
  if (globalctx["memory"]["tours"] != null) {
    List filtered = globalctx["memory"]["tours"];
    filtered = filtered.where((e) {
      if (quoteDate.value.isEmpty) {
        return true;
      }
      return e["date"] == quoteDate.value;
    }).toList();
    filtered = filtered.where((e) {
      if (quoteName.value.isEmpty) {
        return true;
      }
      return e["name"] == quoteName.value;
    }).toList();
    filtered = filtered.where((e) {
      if (quoteId.value.isEmpty) {
        return true;
      }
      return e["quote"].toString() == quoteId.value;
    }).toList();
    filtered = filtered.where((e) {
      if (quoteState.value.isEmpty) {
        return true;
      }
      return e["state"].toString() == quoteState.value;
    }).toList();
    quoteFilter.value = filtered.toList();
    updateDatatable(ctx, quoteFilter.value);
  }
}

getQuoteHistoryHeader(context, data, columns) {
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

processQuoteHistoryData(context, data) {
  var columns = ["quote_name", "quote_format"];
  var header = getQuoteHistoryHeader(context, data, columns);
  var detail = getQuoteHistoryDetail(context, data, columns);
  return [header, detail];
}

getQuoteHistoryDetail(context, data, columns) {
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
        getQuoteHistoryDataCell(context, row),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

getQuoteHistoryDataCell(context, row) {
  var dataCell = DataCell(
    IconButton(
      padding: EdgeInsets.all(0),
      icon: const Icon(Icons.event_note_rounded, size: 20),
      tooltip: 'Show QuoteHistory Itinerary',
      onPressed: () {
        showCustomDialog(
          context,
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "${row['quote_name']}",
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
                  "${processQuoteHistoryItinerary(row)}",
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
                          "${row['quote_itinerary']}"
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
