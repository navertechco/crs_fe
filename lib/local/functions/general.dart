// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:naver_crs/common/functions.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/7/endservices/widgets/index.dart';
import 'package:naver_crs/pages/index.dart';
import 'package:sweetalert/sweetalert.dart';
export 'day.dart';
export 'destination.dart';
export 'experience.dart';


//   .oooooo.                                                       oooo       oooooooooooo                                       .    o8o                                 
//  d8P'  `Y8b                                                      `888       `888'     `8                                     .o8    `"'                                 
// 888            .ooooo.  ooo. .oo.    .ooooo.  oooo d8b  .oooo.    888        888         oooo  oooo  ooo. .oo.    .ooooo.  .o888oo oooo   .ooooo.  ooo. .oo.    .oooo.o 
// 888           d88' `88b `888P"Y88b  d88' `88b `888""8P `P  )88b   888        888oooo8    `888  `888  `888P"Y88b  d88' `"Y8   888   `888  d88' `88b `888P"Y88b  d88(  "8 
// 888     ooooo 888ooo888  888   888  888ooo888  888      .oP"888   888        888    "     888   888   888   888  888         888    888  888   888  888   888  `"Y88b.  
// `88.    .88'  888    .o  888   888  888    .o  888     d8(  888   888        888          888   888   888   888  888   .o8   888 .  888  888   888  888   888  o.  )88b 
//  `Y8bood8P'   `Y8bod8P' o888o o888o `Y8bod8P' d888b    `Y888""8o o888o      o888o         `V88V"V8P' o888o o888o `Y8bod8P'   "888" o888o `Y8bod8P' o888o o888o 8""888P' 
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
     

/// ## loadDummyData
/// *__Method to set data to context__*
///
///### Uses:
/// ```dart
///   if (res['state'] == true) {
///    setContext("catalogs", res['data']);
///  }
/// ```
setContext(key, value) {
  globalctx.set_context(key, value);
  log(globalctx.context.value);
}

/// ## loadDummyData
/// *__Method to get data from context__*
///
///### Uses:
/// ```dart
///  var catalogs = getContext("catalogs");
/// ```
getContext(key) {
  return globalctx.get_context(key);
}

getCountryNameById(id) {
  var country = destinationCountry
      .firstWhere((element) => element["code"] == int.parse(id));
  var name = country["description"];
  return name;
}

showCustomDialog(context, Widget child, String button,
    {Widget? customChild,
    Color backgroundColor = Colors.black54,
    Color buttonColor = Colors.black54,
    double width = 0.5,
    double height = 0.75,
    onSaved}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        backgroundColor: backgroundColor,
        content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            width: MediaQuery.of(context).size.width * width,
            height: MediaQuery.of(context).size.height * height,
            child: child),
        actions: <Widget>[
          Row(
            children: [
              customChild ?? Spacer(),
              TextButton(
                child: Text(button,
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: buttonColor)
                        .getStyle()),
                onPressed: () {
                  if (onSaved != null) {
                    onSaved();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

findTravelRhythmDescription(int code) {
  try {
    if (code == 0) {
      return "HARD";
    }
    var travelData = findCatalog("travel_rhythm").toList();
    var description = travelData
        .firstWhere((element) => element["code"] == code)["description"];
    return description;
  } catch (e) {
    log(e);
  }
}

multiDropDownKaAgeFilter(trCatalog, travelRhytmAges) {
  return trCatalog.value.where((value) {
    var code = value["code"];
    for (var i = 0; i < travelRhytmAges.keys.length; i++) {
      var range = [
        travelRhytmAges.keys.toList()[i],
        travelRhytmAges.keys
            .toList()[i >= travelRhytmAges.keys.length - 1 ? i : i + 1]
      ];
      if (customerAge.value < 20) {
        return true;
      }
      if (customerAge.value >= range[0] && customerAge.value <= range[1]) {
        if (travelRhytmAges[range[0]]!.contains(code.toString())) {
          return true;
        }
      }
    }
    return false;
  }).toList() as List<Map<String, dynamic>>;
}

log(e) {
  print(e);
}

setLT(value) {
  int ltindex =
      expList.indexWhere((element) => element["description"] == "Leisure Time");
  globalctx.context.value["catalogs"]["experiences"][ltindex]["value"]
          ["exptime"] ==
      value;
  experiences = findCatalog("experiences");
}

getHotel(ctx, {int id = 0, int index = 0}) async {
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
            width: 0.35);
      }
    } else {
      SweetAlert.show(ctx,
          curve: ElasticInCurve(),
          title: res['message'],
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
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
        width: 0.35);
  }
}

getCruise(ctx, {int cruiseId = 999, String cruiseName = ''}) async {
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
    SweetAlert.show(ctx,
        curve: ElasticInCurve(),
        title: res['message'],
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
}

resetData(context, controller) {
  var data = globalctx.memory["tours"];
  if (searchResult!.isNotEmpty) {
    controller.clear();
    searchResult!.value = '';
    filteredData.value = data;
    var detail = getDetail(context, filteredData, null);
    searcherDetail.value = (detail);
  }
}

filterData(context, value) {
  var data = globalctx.memory["tours"];
  try {
    searchResult!.value = value.toString();
    if (searchResult!.isNotEmpty) {
      filteredData.value = data
          .where((quote) =>
              quote["date"].toString().contains(searchResult!.value) ||
              quote["name"].toString().contains(searchResult!.value) ||
              quote["quote"].toString().contains(searchResult!.value))
          .toList();
      var detail = getDetail(context, filteredData, null);
      searcherDetail.value = (detail);
    }
  } catch (e) {
    log(e);
  }
}

processNetRateData(context, data) {
  var header = getNetRateHeader(context, data);
  var detail = getNetRateDetail(context, data);
  return [header, detail];
}

getNetRateHeader(context, data) {
  var header = <DataColumn>[];
  if (data.length > 0) {
    for (var key in data[0].keys) {
      String title = key ?? '';
      header.add(DataColumn(
        label: Text(
          title.capitalize!.replaceAll("_", " "),
          style: KTextSytle(
            context: context,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 204, 164, 61),
          ).getStyle(),
        ),
      ));
    }
  }

  return header;
}

getDetail(context, data, columns) {
  var states = [
    "Error",
    "New",
    "Created",
    "Rejected",
    "Cancelled",
    "Expired",
    "Pending",
    "Approved",
  ];
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      var keys = row.keys.toList();

      if (columns != null) {
        keys = columns;
      }

      for (var key in keys) {
        if (key == "state" && row[key] is int) {
          row[key] = states[row[key]];
        }

        cells.add(DataCell(Text('${row[key]}',
            style: KTextSytle(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }
      cells.add(
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'PDF',
              onPressed: () {
                var url =
                    "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/docx.html?doc=${row['travel_code']}";
                showCustomDialog(
                    context,
                    WebView(
                      url: url,
                    ),
                    "Close",
                    buttonColor: Colors.white);
              },
            ),
            IconButton(
              icon: const Icon(Icons.money),
              tooltip: 'Net Rate',
              onPressed: () {
                getTour(context, tourId: row['quote'], detail: true,
                    cb: (data) {
                  if (data.length > 0) {
                    globalctx.memory["tour"] = data[0];
                    showCustomDialog(context, NetRatePage(), "Close",
                        buttonColor: Colors.white, width: 1.0);
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copy',
              onPressed: () {
                getTour(context, tourId: row["quote"], detail: true,
                    cb: (data) {
                  if (data.length > 0) {
                    globalctx.memory["tour"] = data[0];
                    if (row["quote"] == 0) {
                      Get.toNamed("/Searcher");
                    } else {
                      Get.toNamed("/Tour");
                    }
                  }
                });
              },
            ),
          ],
        )),
      );
      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

getNetRateDetail(context, data) {
  var detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      for (var key in row.keys) {
        if (key == '') {}
        cells.add(DataCell(Text('${row[key]}',
            style: KTextSytle(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }

      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

getTrColor(tr) {
  var color = {
    "SOFT": Colors.green,
    "MEDIUM": Colors.yellow,
    "HARD": Colors.red
  };

  return color[tr.toString().toUpperCase()];
}

purposeValidate(values) {
  if (values.length > 3) {
    var mem = [values[0], values[1], values[2]];
    absorvedPurpose.value = true;
    savePurposes(mem);
  } else {
    savePurposes(values);
  }
}

savePurposes(values) {
  if (values == null) return;
  if (values.length <= 3) {
    purposeMemory.value = <String>[];
    var length = values.length;
    for (var i = 0; i < length; i++) {
      purposeMemory.add(filterCatalog("purposes", "code", values[i])[0]
              ["description"]
          .toString());
    }
    setFormValue(globalctx.memory, "tour", "purposes", purposeMemory.value);
  }
}

getDayId(int destId, int destDay) {
  var maxDestDays = getMaxDestDays();
  var currenDestDays = getDestDays(destId);
  var currenDestDaysOff = maxDestDays - currenDestDays;
  pushList(daysOff, destId, currenDestDaysOff);
  var accOff = getAccOff(destId);
  var destMatrixIndex = maxDestDays * destId + destDay;
  var dayId = destMatrixIndex - accOff;
  return dayId;
}

updateDestDays() {
  destDays = [];
  for (var dest in globalctx.memory["destinations"].entries) {
    var destDay = dest.value;
    destDays.add(int.parse(destDay["explorationDay"]));
  }
}

getDestDays(int destId) {
  updateDestDays();
  return destDays[destId];
}

getAccOff(destId) {
  var accOff = 0;
  for (var i = 0; i < destId; i++) {
    accOff += daysOff[i] as int;
  }
  return accOff;
}

getMaxDestDays() {
  updateDestDays();
  var maxValue = getListMaxValue(destDays);
  return maxValue;
}

getTrLimit(value) {
  var trLimits = {
    "soft": 60,
    "medium": 60,
    "hard": 180,
    "0": 60,
    "1": 60,
    "2": 60,
    "3": 180
  };
  var result = trLimits[value.toString().toLowerCase()];
  return result;
}

saveTravelCode(ctrl, value) {
  leadPassenger.value = value!;
  ctrl!.state.leadPassenger = value;
  ctrl!.state.travelCode =
      getTravelCode(getValue(client, "lead_passenger", def: "jose cuevas"));
  travelCode.value = getTravelCode(value);
}

getTravelCode(value) {
  var res = value.toString().replaceAll(" ", "-") +
      "-" +
      tour["passengers"].toString() +
      "-" +
      dayFormat.format(arrivalDate.value).replaceAll(" ", "-") +
      "-" +
      globalctx.memory["tour"]["code"].toString();
  return res;
}
