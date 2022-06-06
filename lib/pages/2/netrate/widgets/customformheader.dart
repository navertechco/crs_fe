import 'package:flutter/material.dart';
import 'customformheaderiter.dart';

class CustomFormHeaderWidget extends StatelessWidget {
  const CustomFormHeaderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    List<CustomFormHeaderIterWidget> list = [];

    for (var i = 0; i < data.length; i++) {
      list.add(CustomFormHeaderIterWidget(data: data, index: i));
    }

    return Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: list,
        ));
  }
}
