// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/7/netrate/widgets/index.dart';
import '../index.dart';
import '../../../index.dart';

/// Searcher
// ignore: must_be_immutable
class SearcherWidget extends GetView<SearcherController> {
  SearcherWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  SearcherController ctrl;
  RxBool newtour = false.obs;
  @override
  Widget build(BuildContext context) {
    List data = [
      {"date": "10-10-2022", "name": "Name1", "quote": "1111"},
      {"date": "11-10-2022", "name": "Name2", "quote": "2222"},
      {"date": "12-10-2022", "name": "Name3", "quote": "3333"},
      {"date": "13-10-2022", "name": "Name4", "quote": "4444"},
    ];
    var processedData = processData(context, data);
    var header = processedData[0];
    var detail = processedData[1];

    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyLayoutWidget(
          background: "assets/custom/img/layout.png",
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.4,
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Text(
                  'Quote History',
                  style: KTextSytle(
                    context: context,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 204, 164, 61),
                  ).getStyle(),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2,
                      top: MediaQuery.of(context).size.height * 0.4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Color.fromARGB(255, 204, 164, 61),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.3,
                    // color: Colors.white,
                    child: DataTable(
                      columns: header,
                      rows: detail,
                    ),
                  )),
            ],
          )),
    );
  }
}

Function processData = (context, data) {
  var header = getHeader(context, data);
  var detail = getDetail(context, data);
  return [header, detail];
};

Function getHeader = (context, data) {
  var header = <DataColumn>[];

  for (var key in data[0].keys) {
    String title = key ?? "";
    header.add(DataColumn(
      label: Text(
        '${title.capitalize}',
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
      'Actions',
      style: KTextSytle(
        context: context,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 204, 164, 61),
      ).getStyle(),
    ),
  ));

  return header;
};

Function getDetail = (context, data) {
  var detail = <DataRow>[];

  for (var row in data) {
    var cells = <DataCell>[];
    for (var key in row.keys) {
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
              showCustomDialog(
                  context,
                  WebView(
                      url:
                          "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/pdf.html"),
                  "Close",
                  buttonColor: Colors.white);
            },
          ),
          IconButton(
            icon: const Icon(Icons.money),
            tooltip: 'Net Rate',
            onPressed: () {
              showCustomDialog(context, Text("NetRate"), "Close",
                  buttonColor: Colors.white);
            },
          ),
          IconButton(
            icon: const Icon(Icons.mode_edit),
            tooltip: 'Edit',
            onPressed: () {
              getTour(context, tourId: 0);
            },
          ),
        ],
      )),
    );
    detail.add(DataRow(cells: cells));
  }
  return detail;
};
