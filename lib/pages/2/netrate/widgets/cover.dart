import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customdescription.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map tour = globalctx.memory["tour"];
    return Column(
      children: [
        CustomDescriptionWidget(
            text: "Net Rate: ${tour["description"]}",
            width: 0.5,
            fontSize: 0.020,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
