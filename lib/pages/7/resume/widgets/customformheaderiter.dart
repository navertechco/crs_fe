
import 'package:flutter/material.dart';

import 'customformheaderrow.dart';

class CustomFormHeaderIterWidget extends StatelessWidget {
  const CustomFormHeaderIterWidget({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List<List<Map<String, dynamic>>> data;
  final int index;
  @override
  Widget build(BuildContext context) {
    List<CustomFormHeaderRowWidget> list = [];

    for (var i = 0; i < data[index].length; i++) {
      list.add(CustomFormHeaderRowWidget(
        customlabel: data[index][i]["description"] + ":",
        value: data[index][i]["value"].toString(),
      ));
    }
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.083),
        Row(
          children: list,
        ),
      ],
    );
  }
}
