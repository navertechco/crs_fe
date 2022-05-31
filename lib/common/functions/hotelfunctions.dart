// ignore_for_file: prefer_function_declarations_over_variables

import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

var budgets = {"1": "5 stars", "0": "4 stars"};

filterHotels(ctx) {
  if (globalctx.memory["hotels"] != null) {
    List filtered = globalctx.memory["hotels"];
    var destData = globalctx.memory["destinations"]
        [currentDestinationIndex.value.toString()];
    var destname = destData["destination"];
    var keyActivity = destData["key_activities"] ?? [];
    var tour = globalctx.memory["tour"];
    var purposes =
        tour["purposes"].map((e) => e.toString().toUpperCase()).toList();
    var budget = budgets[tour["accomodation_type"] ?? "1"];

    //budget_fk
    filtered = filtered.where((element) {
      var rule = true;
      var max = element["value"]["budget_fk"];
      if (hotelCategory.value.isNotEmpty) {
        rule = hotelCategory.value == max.toString();
      }
      return rule;
    }).toList();
    //hotelname
    filtered = filtered.where((element) {
      var rule = true;
      var max = element["value"]["hotelname"];
      if (hotelName.value.isNotEmpty) {
        rule = hotelName.value == max.toString();
      }
      return rule;
    }).toList();
    //RoomType x MaxCapacity vs PAX
    filtered = filtered.where((element) {
      var rule = true;
      var rt = element["value"]["#roomtypes"] == ""
          ? 1
          : element["value"]["#roomtypes"];
      var mc = element["value"]["maxCapacity"];
      var pax = globalctx.memory["tour"]["passengers"];
      if (purposes.isNotEmpty) {
        rule = rt * mc >= pax;
      }
      return rule;
    }).toList();
    //Purpose
    filtered = filtered.where((element) {
      var rule = true;
      var p1 = element["value"]["purpose_fk"].toString().toUpperCase();
      var p2 = element["value"]["purpouse_fk.1"].toString().toUpperCase();
      var p3 = element["value"]["purpouse_fk.2"].toString().toUpperCase();
      if (purposes.isNotEmpty) {
        rule = purposes.contains(p1) |
            purposes.contains(p2) |
            purposes.contains(p3);
      }
      return rule;
    }).toList();

    //Key Activities
    filtered = filtered.where((element) {
      var rule = true;
      var k1 = element["value"]["keyActivityType_fk"];
      var k2 = element["value"]["keyActivityType_fk.1"];
      var k3 = element["value"]["keyActivityType_fk.2"];
      if (keyActivity.isNotEmpty) {
        rule = keyActivity.contains(k1) |
            keyActivity.contains(k2) |
            keyActivity.contains(k3);
      }
      return rule;
    }).toList();

    //Destination
    filtered = filtered.where((element) {
      var rule = true;
      var dest = element["relation"]["destination"];
      if (destname != null) {
        rule = destname == dest.toString();
      }
      return rule;
    }).toList();

    // //Budget
    // filtered = filtered.where((element) {
    //   var rule = true;
    //   var b1 = element["value"]["budget_fk"];
    //   if (budget!.isNotEmpty) {
    //     rule = budget == b1.toString();
    //   }
    //   return rule;
    // }).toList();
    hotelResults.value = filtered.toList();

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

var currentHotelName = Rx(getFormValue(
    globalctx.memory["destinations"], globalDestinationIndex, "hotelName", ""));

getHotelDataCell(context, row) {
  var dataCell = DataCell(
    Row(
      children: [
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
                      "${row["value"]['roomcategory']}",
                      style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61),
                      ).getStyle(),
                    ),
                    Text(
                      "${row["value"]['roomdescription']}",
                      style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ).getStyle(),
                    ),
                  ],
                ),
              ),
              "Close",
              backgroundColor: Color.fromARGB(100, 0, 0, 0),
            );
          },
        ),
        Obx(() => CheckboxIconFormField(
              padding: 0,
              initialValue: currentHotelName.value == row["description"],
              onChanged: (value) {
                currentHotelName.value = row["description"];
                setFormValue(
                    globalctx.memory["destinations"],
                    globalDestinationIndex,
                    "hotelName",
                    currentHotelName.value);
              },
            )),
      ],
    ),
  );
  return dataCell;
}
