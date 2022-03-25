// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import '../../../index.dart';
import 'index.dart';

/// Searcher
// ignore: must_be_immutable
class TotalNetRateWidget extends GetView<SearcherController> {
  TotalNetRateWidget({Key? key, this.row}) : super(key: key);
  final row;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var processedData = processNetRateData(context, netRateData);
    netRateHeader = Rx(processedData[0]);
    if (searchResult!.value.isEmpty) {
      netRateDetail = Rx(processedData[1]);
    }

    return Form(
        key: _formKey,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.width * 0.0,
                  ),
                  child: Text(
                    'Net Rate: Quote ${row["quote"]}',
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
                      left: MediaQuery.of(context).size.width * 0.0,
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
                          var t = netRateHeader.value;
                          return Column(
                            children: [
                              // SearcherField(data: data, formKey: _formKey),
                              DataTable(
                                columns: netRateHeader.value,
                                rows: netRateDetail.value,
                              ),
                            ],
                          );
                        }),
                      ),
                    )),
              ],
            )));
  }
}
