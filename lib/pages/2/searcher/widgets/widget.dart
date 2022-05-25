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
    var processedData = processData(context, globalctx.memory["tours"], null);
    searcherHeader.value = processedData[0];
    if (searchResult!.value.isEmpty) {
      searcherDetail.value = processedData[1];
    }

    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
          
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(
                        color: Color.fromARGB(255, 204, 164, 61),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: MediaQuery.of(context).size.width * 0.8,
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
        ),
      ),
    );
  }
}
