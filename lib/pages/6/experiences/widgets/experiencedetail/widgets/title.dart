import 'package:flutter/material.dart';
import '../../../../../index.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);

  final experience;

  @override
  Widget build(BuildContext context) {
    var expData = getExperienceByName(experience).value;
    return Column(
      children: [
        Text(experience.toString().split("-")[0],
            style: KTextSytle(
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 204, 164, 61))
                .getStyle()),
        Row(
          children: [
            Text("Open Days: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["openDays"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            Text("Open Time: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["openTime"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            Text("Close Time: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["closeTime"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        )
      ],
    );
  }
}
