import 'package:flutter/material.dart';
import '../../../../../index.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    var experiences = processCatalog("experiences");
    var expData = experiences
        .toList()
        .firstWhere((exp) => exp["description"] == experience)["value"];
    return Text("${expData["description"]}",
        style: KTextSytle(
                context: context,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 128, 128, 128))
            .getStyle());
  }
}
