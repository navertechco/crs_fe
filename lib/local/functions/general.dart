// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/7/endservices/widgets/index.dart';
export 'day.dart';
export 'destination.dart';
export 'experience.dart';

//  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗
// ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║
// ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║
// ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║
// ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
//  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

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

/// ## getCountryNameById
/// *__Method to clear Hours__*
///
///### Uses:
/// ```dart
///      var countryName = getCountryNameById(destCountry.value);
/// ```
/// ### Returns:
///```dart
/// String
///```
String getCountryNameById(id) {
  var country = destinationCountry
      .firstWhere((element) => element["code"] == int.parse(id));
  String name = country["description"];
  return name;
}

/// ## showCustomDialog
/// *__Method to show Custom diaglog__*
///
///### Uses:
/// ```dart
///      showCustomDialog(context, NetRatePage(), "Close",
///                    buttonColor: Colors.white, width: 1.0);
/// ```
/// ### Returns:
///```dart
/// void
///```
void showCustomDialog(context, Widget child, String button,
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
        // contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        backgroundColor: backgroundColor,
        content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            width: MediaQuery.of(context).size.width * isMobile * width,
            height: MediaQuery.of(context).size.height * isMobile * height,
            child: child),
        actions: <Widget>[
          Wrap(
            children: [
              customChild ?? SizedBox(),
              TextButton(
                child: Text(button,
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
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

/// ## log
/// *__Method print log messages__*
///
///### Uses:
/// ```dart
///     log(e);
/// ```
/// ### Returns:
///```dart
/// void
///```
void log(e) {
  print(e);
}

/// ## processNetRateData
/// *__Method to process net rate Data to build DataTable__*
///
///### Uses:
/// ```dart
///     var processedData = processNetRateData(context, netRateData);
/// ```
/// ### Returns:
///```dart
/// List
///```
List processNetRateData(context, data) {
  var header = getNetRateHeader(context, data);
  var detail = getNetRateDataRows(context, data);
  return [header, detail];
}

/// ## getNetRateHeader
/// *__Method to process net rate Header to build DataTable__*
///
///### Uses:
/// ```dart
///     var header = getNetRateHeader(context, data);
/// ```
/// ### Returns:
///```dart
/// List
///```
List<DataColumn> getNetRateHeader(context, data) {
  List<DataColumn> result = <DataColumn>[];
  if (data.length > 0) {
    for (var key in data[0].keys) {
      String title = key ?? '';
      result.add(DataColumn(
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

  return result;
}

/// ## getTourDataRows
/// *__Method to process Tour Detail DataRows to build DataTable__*
///
///### Uses:
/// ```dart
///     var detail = getTourDataRows(context, filteredData, null);
/// ```
/// ### Returns:
///```dart
/// List<DataRow>
///```
List<DataRow> getTourDataRows(context, data, columns) {
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
  List<DataRow> detail = <DataRow>[];
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
                    fontSize: 15,
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

/// ## getNetRateDataRows
/// *__Method to process net rate Detail DataRows to build DataTable__*
///
///### Uses:
/// ```dart
///     var detail = getNetRateDataRows(context, filteredData, null);
/// ```
/// ### Returns:
///```dart
/// List<DataRow>
///```
List<DataRow> getNetRateDataRows(context, data) {
  List<DataRow> detail = <DataRow>[];
  if (data.length > 0) {
    for (var row in data) {
      var cells = <DataCell>[];
      for (var key in row.keys) {
        if (key == '') {}
        cells.add(DataCell(Text('${row[key]}',
            style: KTextSytle(
                    context: context,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
                .getStyle())));
      }

      detail.add(DataRow(cells: cells));
    }
  }

  return detail;
}

/// ## getTravelRhythmColor
/// *__Method to get Ravel Rhythm Color__*
///
///### Uses:
/// ```dart
///     color: getTravelRhythmColor(getExperienceValueByName(experience)["travel_rhythm"]),
/// ```
/// ### Returns:
///```dart
/// Color?
///```
Color? getTravelRhythmColor(String travelRhythmName) {
  Map<String, Color> color = {
    "SOFT": Colors.green,
    "MEDIUM": Colors.yellow,
    "HARD": Colors.red
  };

  Color? result = color[travelRhythmName.toString().toUpperCase()];
  return result;
}

/// ## validatePurposes
/// *__Method to validate purpose before saving it__*
///
///### Uses:
/// ```dart
///     onSaved: (values) {
///          validatePurposes(values);
///        },
/// ```
/// ### Returns:
///```dart
/// void
///```
void validatePurposes(values) {
  if (values.length > 3) {
    var mem = [values[0], values[1], values[2]];
    absorvedPurpose.value = true;
    savePurposes(mem);
  } else {
    savePurposes(values);
  }
}

/// ## savePurposes
/// *__Method to save purposes__*
///
///### Uses:
/// ```dart
///       savePurposes(values);
/// ```
/// ### Returns:
///```dart
/// void
///```
void savePurposes(values) {
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

/// ## getTravekRhythmLimit
/// *__Method to get travel Rhythm Limit__*
///
///### Uses:
/// ```dart
///       getTravekRhythmLimit(currentTravelRhythm.value))
/// ```
/// ### Returns:
///```dart
///   int
///```
int getTravekRhythmLimit(String value) {
  Map trLimits = {
    "soft": 60,
    "medium": 60,
    "hard": 180,
    "0": 60,
    "1": 60,
    "2": 60,
    "3": 180
  };
  int result = trLimits[value.toString().toLowerCase()];
  return result;
}

/// ## saveCustomerTravelCode
/// *__Method to save Customer Travel Code__*
///
///### Uses:
/// ```dart
///       onSaved: (value) {
///                             saveCustomerTravelCode(ctrl, value);
///                           },
/// ```
/// ### Returns:
///```dart
///   void
///```
void saveCustomerTravelCode(value) {
  travelCode.value = value!;
  var res = getCustomerTravelCode(value);
  setFormValue(globalctx.memory, "tour", "travel_code", res);
}

saveCustomer(state) {
  resetAllDestinations();
  gotoPage("Destination");
}

/// ## getCustomerTravelCode
/// *__Method to save Customer Travel Code__*
///
///### Uses:
/// ```dart
///      ctrl!.state.travelCode =
/// getCustomerTravelCode(getValue(client, "lead_passenger", def: ""));
/// ```
/// ### Returns:
///```dart
///   String
///```
String getCustomerTravelCode(value) {
  String res = value.toString().replaceAll(" ", "-") +
      "-" +
      tour["passengers"].toString() +
      "-" +
      dayFormat.format(arrivalDate.value).replaceAll(" ", "-") +
      "-" +
      globalctx.memory["tour"]["code"].toString();
  return res;
}
