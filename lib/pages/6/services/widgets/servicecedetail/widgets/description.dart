import 'package:flutter/material.dart';
import '../../../../../index.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  final service;

  @override
  Widget build(BuildContext context) {
    var expData = findCatalog("Services")
        .toList()
        .firstWhere((exp) => exp["description"] == service)["value"];
    return Text("${expData["description"]}",
        style: KTextSytle(
                context: context,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 128, 128, 128))
            .getStyle());
  }
}
