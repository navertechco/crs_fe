import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomStarDestinationForm extends StatelessWidget {
  const CustomStarDestinationForm({
    Key? key,
    required this.destination,
  }) : super(key: key);
  final String destination;
  @override
  Widget build(BuildContext context) {
   
    var destinations = getContext('destinations');
    return Column(
      children: [
        // Obx(() {
        //   return Text(destination +
        //       "  ${globalctx.value}" +
        //       "  ${globalctx.destinationlist.contains(destination)}");
        // }),
        Obx(() {
          if (globalctx.destinationlist.contains(destination)) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0,
                left: MediaQuery.of(context).size.width * 0,
              ),
              child: SizedBox(
                child: Column(children: [
                  CustomTitleWidget(
                    width: 0.2,
                    fontWeight: FontWeight.bold,
                    label: destinations[destination][1],
                  ),
                  const CustomFormDropDownFieldWidget(
                    label: "Exploration Days       ",
                    data: [
                      {"code": "1", "description": "1"},
                      {"code": "2", "description": "2"},
                      {"code": "3", "description": "3"},
                      {"code": "4", "description": "4"},
                      {"code": "5", "description": "5"},
                      // {"code": "2", "description": "hola 2"},
                    ],
                  ),
                  const CustomTitleWidget(
                      width: 0.225,
                      fontWeight: FontWeight.bold,
                      label: "  Exploration Mode"),
                  const CustomFormDropDownFieldWidget(
                    label: "    Purpose                    ",
                    data: [
                      {"code": "1", "description": "AVENTURE"},
                      {"code": "2", "description": "CULLINARY"},
                    ],
                  ),
                  const CustomTitleWidget(
                      width: 0.2,
                      fontWeight: FontWeight.bold,
                      label: "  Destination options           "),
                  const CustomTitleWidget(
                      width: 0.2,
                      fontWeight: FontWeight.bold,
                      label: "  Travel Rithm           "),
                  const Divider(color: Color.fromARGB(255, 0, 0, 0)),
                ]),
              ),
            );
          } else {
            return const Text("");
          }
        }),
      ],
    );
  }
}
  
  

