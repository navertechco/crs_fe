// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../index.dart';
import '../../../index.dart';
import 'index.dart';

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
                              SearcherField(data: data, formKey: _formKey),
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
