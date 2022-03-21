// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../index.dart';
export 'dayfunctions.dart';
export './destinationfunctions.dart';
export './experiencefunctions.dart';

// Other Functions
Future<bool> getCatalog(
  List<String> catalogs,
) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCatalogPath, 'POST', {
    "data": {"catalogs": catalogs}
  });
  // ignore: avoid_print
  // print(res);
  if (res['state'] == true) {
    setContext("catalogs", res['data']);
    return true;
  } else {
    return false;
  }
}

RxList<Map<String, dynamic>> daysCatalog = <Map<String, dynamic>>[].obs;

Function processCatalog = (name) {
  var catalogs = getContext("catalogs");
  List<Map<String, dynamic>> catalog = [];
  if (catalogs != null) {
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        Map<String, dynamic> row = {};
        row["code"] = item["code"];
        row["description"] = item["description"];
        row["value"] = item["value"];
        row["relation"] = item["relation"];
        catalog.add(row);
      }
    }
  }
  return catalog;
};
Function getDateValue = (data, key, {def}) {
  try {
    if (data ?? true) {
      if (data[key] ?? true) {
        return DateTime.parse(data[key]);
      }
    } else {
      return def;
    }
  } catch (e) {
    return def;
  }
};
Function getValue = (data, key, {def}) {
  try {
    if (data ?? true) {
      if (data[key] ?? true) {
        return data[key].toString();
      }
    } else {
      return def;
    }
  } catch (e) {
    return def;
  }
};
Function validateData = (data) {
  return data != null ? data.length > 0 : false;
};
Function getData = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : "0";
};
Function getDataList = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : <Map<String, dynamic>>[];
};
Function getParam = (key) {
  var params = processCatalog("params");
  var child =
      params.toList().firstWhere((element) => element["description"] == key);
  return child;
};
Function cityData = (Rx<List<Map<String, dynamic>>> citylist, cities) {
  var index = 0;
  citylist.value = [];
  for (var city in cities) {
    citylist.value.add({
      "code": "$index",
      "description": city,
    });
    index++;
  }
};
Function globalctxReset = () {
  globalctx.experiences.value = {};
  globalctx.experienceDragData.value = {};
  globalctx.reset.value = true;
  resetDays();
  resetDestinations();
  updateDraggableDestinations();
  filterDestinations();
  resetExperiences();
};

Function getItems = (data, value) {
  RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
  List<Map<String, dynamic>> data2 = [];
  data2.add({"code": "0", "description": "Choose a Option"});
  if (data.isNotEmpty) {
    items = <DropdownMenuItem<String>>[].obs;
    data2.addAll(data);
    data2.asMap().forEach((index, item) {
      items.add(DropdownMenuItem(
        value: item["code"].toString(),
        child: Text(item["description"]),
      ));
    });
  }
  return items;
};
Function chunkMap = (data, int portion, List<Map<String, dynamic>> list) {
  List<List<Map<String, dynamic>>> chunks = [];
  int aprox = (list.length / portion).round() * portion;
  int module = aprox > list.length
      ? (list.length / portion).round()
      : (list.length / portion).round() + 1;
  for (var i = 0; i < module; i++) {
    chunks.add([]);
    for (var j = 0; j < portion; j++) {
      var index = (i * portion) + j;
      if (index > list.length - 1) {
        break;
      }
      Map<String, dynamic> item = list[index];
      String code = item["code"];
      item["value"] = data[code];
      chunks[i].add(item);
    }
  }
  return chunks;
};
Function isMobileDevice = () {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
};
Function setData = (data, key, value) {
  data[key] = value;
};
Function getFormValue = (data, formKey, key, def) {
  formKey = formKey.toString();
  if (data != null) {
    if (data[formKey] != null) {
      if (data[formKey][key] != null) {
        if (data[formKey][key] == "") {
          return def;
        }
        return data[formKey][key] ?? def;
      }
    }
  }
  return def;
};
Function getFormDateValue = (data, formKey, key, def) {
  if (data != null) {
    if (data[formKey] != null) {
      if (data[formKey][key] != null) {
        if (data[formKey][key] == "") {
          return DateTime.parse(def);
        }
        return DateTime.parse(data[formKey][key]);
      }
    }
  }
  return DateTime.parse(def);
};
Function toCatalog = (item) {
  List list = item.values.toList();
  CatalogDto ctlg = CatalogDto(list);
  return ctlg;
};
Function parseIntValue = (value) {
  if (value is int) {
    return value;
  }
  value ??= "0";
  if (value == "") {
    value = "0";
  }
  value = value.replaceAll(RegExp(r'[^0-9]'), '').replaceAll("-", "");
  return int.parse(value);
};
Function setFormValue = (data, formKey, key, value) {
  try {
    data ??= {}.obs;
    formKey = formKey.toString();
    if (data[formKey] == null) {
      data[formKey] = {}.obs;
    }
    data[formKey][key] = value;
  } catch (e) {}
};
dynamic myEncode(dynamic item) {
  if (item is DateTime || item is Map) {
    return item.toIso8601String();
  }
  return item;
}

Function getCountryNameById = (id) {
  var country = destinationCountry
      .firstWhere((element) => element["code"] == int.parse(id));
  var name = country["description"];
  return name;
};
Future<void> showMyDialog(context, String title, String errorText,
    String question, String button) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(errorText),
              Text(question),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(button),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showCustomDialog(context, Widget child, String button) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black54,
        content: Container(
            width: MediaQuery.of(context).size.width * 0.5, child: child),
        actions: <Widget>[
          TextButton(
            child: Text(button,
                style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)
                    .getStyle()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Function findTravelRhythmDescription = (int code) {
  var travelData = processCatalog("travel_rhythm").toList();
  var description = travelData
      .firstWhere((element) => element["code"] == code)["description"];
  return description;
};
Function parseInt = (value) {
  if (value is String) {
    return int.parse(value);
  }
  return value;
};
Function multiDropDownKaAgeFilter = (trCatalog, travelRhytmAges) {
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
};

