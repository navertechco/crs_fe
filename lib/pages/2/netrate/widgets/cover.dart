import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customdescription.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Map tour = globalctx.memory["tour"];
    var title = tour["title"] ?? "Net Rates";
    var description = "";
    return Column(
      children: [
        CustomDescriptionWidget(
            text: title,
            width: 0.25,
            fontSize: 0.020,
            fontWeight: FontWeight.bold),
        CustomDescriptionWidget(
            text: description,
            width: 0.55,
            fontSize: 0.012,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
