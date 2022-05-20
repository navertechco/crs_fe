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

var budgets = {"1": "5 stars", "0": "4 stars"};

filterHotels(ctx) {
  if (globalctx.memory["hotels"] != null) {
    List filtered = globalctx.memory["hotels"];
    var destData = globalctx.memory["destinations"]
        [currentDestinationIndex.value.toString()];
    var destname = destData["destination"];
    var keyActivity = destData["key_activities"];
    var tour = globalctx.memory["tour"];
    var purposes = tour["purposes"];
    var budget = budgets[tour["accomodation_type"] ?? "1"];
    //Destination
    filtered = filtered.where((element) {
      var rule = true;
      var dest = element["relation"]["destination"];
      if (destname.isNotEmpty) {
        rule = destname == dest;
      }
      return rule;
    }).toList();
    //Budget
    filtered = filtered.where((element) {
      var rule = true;
      var b1 = element["value"]["budget_fk"];
      if (budget!.isNotEmpty) {
        rule = budget == b1;
      }
      return rule;
    }).toList();
    //Purpose
    filtered = filtered.where((element) {
      var rule = true;
      var p1 = element["value"]["purpose_fk"];
      var p2 = element["value"]["purpose_fk.1"];
      var p3 = element["value"]["purpose_fk.2"];
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
    //Max Capacity
    filtered = filtered.where((element) {
      var rule = true;
      var max = element["value"]["maxCapacity"];
      if (hotelMaxCapacity.value.isNotEmpty) {
        rule = hotelMaxCapacity.value == max;
      }
      return rule;
    }).toList();
    //Room Category
    filtered = filtered.where((element) {
      var rule = true;
      var room = element["value"]["roomcategory"];
      if (hotelRoomCategory.value.isNotEmpty) {
        rule = hotelRoomCategory.value == room;
      }
      return rule;
    }).toList();
    //Terrace or Patio
    filtered = filtered.where((element) {
      var rule = true;
      var top = element["value"]["TerraceorPatio"];
      if (hotelTerraceorPatio.value.isNotEmpty) {
        rule = hotelTerraceorPatio.value == top;
      }
      return rule;
    }).toList();
    //Balcony
    filtered = filtered.where((element) {
      var rule = true;
      var balcony = element["value"]["Balcony"];
      if (hotelBalcony.value.isNotEmpty) {
        rule = hotelBalcony.value == balcony;
      }
      return rule;
    }).toList();
    //Extrabed
    filtered = filtered.where((element) {
      var rule = true;
      var extra = element["value"]["extrabed"];
      if (hotelExtrabed.value.isNotEmpty) {
        rule = hotelExtrabed.value == extra;
      }
      return rule;
    }).toList();
    //Pet Friendly
    filtered = filtered.where((element) {
      var rule = true;
      var pet = element["value"]["petFriendly"];
      if (hotelPetFriendly.value.isNotEmpty) {
        rule = hotelPetFriendly.value == pet;
      }
      return rule;
    }).toList();
    //Tub or Jacuzzi
    filtered = filtered.where((element) {
      var rule = true;
      var toj = element["value"]["TuborJacuzzi"];
      if (hotelTuborJacuzzi.value.isNotEmpty) {
        rule = hotelTuborJacuzzi.value == toj;
      }
      return rule;
    }).toList();
    //Child Friendly
    filtered = filtered.where((element) {
      var rule = true;
      var cf = element["value"]["childFriendly"];
      if (hotelChildFriendly.value.isNotEmpty) {
        rule = hotelChildFriendly.value == cf;
      }
      return rule;
    }).toList();
    //Infant Friendly
    filtered = filtered.where((element) {
      var rule = true;
      var infant = element["value"]["infantFriendly"];
      if (hotelInfantFriendly.value.isNotEmpty) {
        rule = hotelInfantFriendly.value == infant;
      }
      return rule;
    }).toList();

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
                // Image.network(
                //   "${row['image']}",
                //   width: MediaQuery.of(context).size.width * 0.5,
                //   height: MediaQuery.of(context).size.height * 0.5,
                // ),
                // Text(
                //   "${processHotelItinerary(row)}",
                //   style: KTextSytle(
                //     context: context,
                //     fontSize: 10,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ).getStyle(),
                // ),
                // Obx(() {
                //   try {
                //     return SfCalendar(
                //       firstDayOfWeek: 1,
                //       backgroundColor: Colors.white,
                //       minDate: arrivalDate.value.add(Duration(days: 1)),
                //       maxDate: departureDate.value.add(Duration(days: -1)),
                //       view: CalendarView.month,
                //       dataSource: MeetingDataSource(getDataSource(
                //           "${row['hotel_itinerary']}"
                //               .replaceAll("[", " ")
                //               .replaceAll("]", " "))),
                //       monthViewSettings: MonthViewSettings(
                //           appointmentDisplayMode:
                //               MonthAppointmentDisplayMode.appointment),
                //     );
                //   } catch (e) {
                //     log(e);
                //     return Text(
                //       "No Calendar Aivalable",
                //       style: KTextSytle(
                //         context: context,
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold,
                //         color: Color.fromARGB(255, 204, 164, 61),
                //       ).getStyle(),
                //     );
                //   }
                // })
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
