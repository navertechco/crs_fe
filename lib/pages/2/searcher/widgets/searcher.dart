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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var processedData = processData(context, data);
      searcherHeader = Rx(processedData[0]);
    if (searchResult!.value.isEmpty) {
      searcherDetail = Rx(processedData[1]);
    }

    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: BodyLayoutWidget(
            background: "assets/custom/img/layout.png",
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.width * 0.4,
                  ),
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
                      top: MediaQuery.of(context).size.height * 0.3,
                      left: MediaQuery.of(context).size.width * 0.2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Color.fromARGB(255, 204, 164, 61),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.6,
                      // color: Colors.white,
                      child: SingleChildScrollView(
                        child: Obx(() {
                          var t = searcherHeader.value;
                          return Column(
                            children: [
                              Searcher(data: data, formKey: _formKey),
                              DataTable(
                                columns: searcherHeader.value,
                                rows: searcherDetail.value,
                              ),
                            ],
                          );
                        }),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class Searcher extends StatelessWidget {
  const Searcher({Key? key, this.data, required this.formKey})
      : super(key: key);

  final List? data;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    TextEditingController? controller = TextEditingController();

    Function filterData = (value) {
      searchResult!.value = value;
      filteredData.value = data!
          .where((quote) =>
              quote["date"].contains(searchResult!.value) ||
              quote["name"].contains(searchResult!.value) ||
              quote["quote"].contains(searchResult!.value))
          .toList();
      var detail = getDetail(context, filteredData);
      searcherDetail.value = (detail);
    };

    return Obx(() {
      var t = searchResult!.value;
      return Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextFormField(
              // controller: controller,
              initialValue:
                  searchResult!.value == "" ? null : searchResult!.value,
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                filterData(value);
              },
              onFieldSubmitted: (value) {
                formKey.currentState!.save();
              },
              onSaved: (value) {
                filterData(value);
              }),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              if (searchResult!.value.isNotEmpty) {
                controller.clear();
                searchResult!.value = '';
                filteredData.value = data!;
                var detail = getDetail(context, filteredData);
                searcherDetail.value = (detail);
              }
            },
          ),
        ),
      );
    });
  }
}

Function processData = (context, data) {
  var header = getHeader(context, data);
  var detail = getDetail(context, data);
  return [header, detail];
};

Function getHeader = (context, data) {
  var header = <DataColumn>[];
  if (data.length > 0) {
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
  }

  return header;
};

Function getDetail = (context, data) {
  var detail = <DataRow>[];
  if (data.length > 0) {
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
  }

  return detail;
};
