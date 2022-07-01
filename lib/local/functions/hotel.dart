// ignore_for_file: prefer_function_declarations_over_variables, curly_braces_in_flow_control_structures

import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

// ██╗  ██╗ ██████╗ ████████╗███████╗██╗
// ██║  ██║██╔═══██╗╚══██╔══╝██╔════╝██║
// ███████║██║   ██║   ██║   █████╗  ██║
// ██╔══██║██║   ██║   ██║   ██╔══╝  ██║
// ██║  ██║╚██████╔╝   ██║   ███████╗███████╗
// ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚══════╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## filterHotels
/// *__Method to filter Hotels__*
///
///### Uses:
/// ```dart
///        filterHotels(context);
/// ```
/// ### Returns:
///```dart
///   void
///```
void filterHotels(ctx) {
  hotelResults.value = [];
  filteredHotel = findCatalog("hotel");

  //DESTINATION
  filteredHotel = filteredHotel.where((element) {
    var rule = true;
    var dest = element["relation"]["destination"];
    rule = globalDestinationName.value == dest.toString();
    return rule;
  }).toList();

  //PURPOSE
  var purposes = globalctx.memory["tour"]["purposes"]
      .map((e) => e.toString().toUpperCase())
      .toList();
  filteredHotel = filteredHotel.where((element) {
    var rule = true;
    var p1 = element["value"]["purpose_fk"].toString().toUpperCase();
    var p2 = element["value"]["purpouse_fk.1"].toString().toUpperCase();
    var p3 = element["value"]["purpouse_fk.2"].toString().toUpperCase();
    if (purposes.isNotEmpty) {
      rule =
          purposes.contains(p1) | purposes.contains(p2) | purposes.contains(p3);
    }
    return rule;
  }).toList();

  //KEY_ACTIVITIES
  var destData = globalctx.memory["destinations"]
      [currentDestinationIndex.value.toString()];
  if (destData != null) {
    var keyActivity = destData["key_activities"] ?? [];
    filteredHotel = filteredHotel.where((element) {
      var rule = true;
      if (keyActivity.isNotEmpty) {
        var k1 = element["value"]["keyActivityType_fk"];
        var k2 = element["value"]["keyActivityType_fk.1"];
        var k3 = element["value"]["keyActivityType_fk.2"];

        rule = keyActivity.contains(k1) |
            keyActivity.contains(k2) |
            keyActivity.contains(k3);
      }
      return rule;
    }).toList();
  }

  //BUDGET
  if (hotelCategory.isNotEmpty)
    filteredHotel = filteredHotel.where((element) {
      var rule = true;
      var max = element["value"]["budget_fk"];
      if (hotelCategory.isNotEmpty) {
        rule = hotelCategory.value == max.toString();
      }
      return rule;
    }).toList();

  //HOTELNAME
  if (hotelName.isNotEmpty)
    filteredHotel = filteredHotel.where((element) {
      var rule = true;
      var max = element["value"]["hotelname"];
      rule = hotelName.value == max.toString();
      return rule;
    }).toList();

  //RoomType x MaxCapacity vs PAX
  filteredHotel = filteredHotel.where((element) {
    var rule = true;
    var capacity = getHotelCapacity(element["value"]["hotelname"]);
    var pax = globalctx.memory["tour"]["passengers"];
    rule = capacity >= pax;
    return rule;
  }).toList();

  //FINAL RESULT
  hotelResults.value = filteredHotel.toList();

  //BUILD TABLE
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

/// ## getHotelCapacity
/// *__Method to Hotel Capacity__*
///
///### Uses:
/// ```dart
///        var capacity = getHotelCapacity(element["value"]["hotelname"]);
/// ```
/// ### Returns:
///```dart
///   int
///```
int getHotelCapacity(hotelName) {
  var hotels = findCatalog("hotel");
  int capacity = 0;
  hotels = hotels
      .where((element) => element["value"]["hotelname"] == hotelName)
      .toList();
  for (var hotel in hotels) {
    int rt =
        hotel["value"]["#roomtypes"] == '' ? 10 : hotel["value"]["#roomtypes"];
    int mc = hotel["value"]["maxCapacity"];
    capacity = capacity + (rt * mc);
  }
  return capacity;
}

/// ## filterHotels
/// *__Method to filter Hotels__*
///
///### Uses:
/// ```dart
///        filterHotels(context);
/// ```
/// ### Returns:
///```dart
///   void
///```
getHotelHeader(context, data, columns) {
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

/// ## filterHotels
/// *__Method to filter Hotels__*
///
///### Uses:
/// ```dart
///        filterHotels(context);
/// ```
/// ### Returns:
///```dart
///   void
///```
processHotelData(context, data) {
  var columns = ["description"];
  var header = getHotelHeader(context, data, columns);
  var detail = getHotelDetail(context, data, columns);
  return [header, detail];
}

/// ## filterHotels
/// *__Method to filter Hotels__*
///
///### Uses:
/// ```dart
///        filterHotels(context);
/// ```
/// ### Returns:
///```dart
///   void
///```
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

/// ## showHotelResultDialog
/// *__Method show Hotel Result dialog__*
///
///### Uses:
/// ```dart
///      showHotelResultDialog(context, id: 0, index: index);
/// ```
/// ### Returns:
///```dart
/// void
///```
void showHotelResultDialog(ctx, {int id = 0, int index = 0}) async {
  currentDestinationIndex.value = index;
  if (globalctx.memory["hotels"] == null) {
    var frame = {
      "data": {"id": id}
    };
    var res = await fetchHandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultFindHotel, 'POST', frame);
    // ignore: avoid_print
    log(res);
    if (res['state'] == true) {
      var data = res['data'];
      if (data.length > 0) {
        globalctx.memory["hotels"] = data;
        showCustomDialog(
            ctx,
            HotelCalendarWidget(
              ctx: ctx,
            ),
            "Close",
            customChild: HotelKeyPadWidget(),
            backgroundColor: Colors.white,
            buttonColor: Colors.black,
            height: 0.25,
            width: 0.3);
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
  } else {
    showCustomDialog(
        ctx,
        HotelCalendarWidget(
          ctx: ctx,
        ),
        "Close",
        customChild: HotelKeyPadWidget(),
        backgroundColor: Colors.white,
        buttonColor: Colors.black,
        height: 0.25,
        width: 0.3);
  }
}

/// ## filterHotels
/// *__Method to filter Hotels__*
///
///### Uses:
/// ```dart
///        filterHotels(context);
/// ```
/// ### Returns:
///```dart
///   void
///```
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
                        fontSize: 15,
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
        CustomFormCounterFieldWidget(
            initial: getFormValue(globalctx.memory["destinations"],
                globalDestinationIndex, "hotelPax.${row["description"]}", 0),
            min: 0,
            max: 50,
            step: 1,
            original: true,
            onValueChanged: (value) {
              setFormValue(
                  globalctx.memory["destinations"],
                  globalDestinationIndex,
                  "hotelPax.${row["description"]}",
                  value);
            },
            label: '',
            width: 0.2),
        Obx(() => CheckboxIconFormField(
              padding: 0,
              initialValue: getFormValue(
                  globalctx.memory["destinations"],
                  globalDestinationIndex,
                  "hotelName.${row["description"]}",
                  false),
              onChanged: (value) {
                setFormValue(
                    globalctx.memory["destinations"],
                    globalDestinationIndex,
                    "hotelName.${row["description"]}",
                    value);
                currentHotelName.value +=
                    currentHotelName.value + row["description"];
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
