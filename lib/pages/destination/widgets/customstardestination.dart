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
                    label: "Exploration Days     ",
                    data: [
                      {"code": "1", "description": "1"},
                      {"code": "2", "description": "2"},
                      {"code": "3", "description": "3"},
                      {"code": "4", "description": "4"},
                      {"code": "5", "description": "5"},
                      // {"code": "2", "description": "hola 2"},
                    ],
                  ),
                  SizedBox(
                    child: (() {
                      if (destination == "galapagos") {
                        return const CustomFormDropDownFieldWidget(
                          label: "Exploration Mode   ",
                          data: [
                            {"code": "1", "description": "Cruiser"},
                            {"code": "2", "description": "Hop Island"},
                            {"code": "3", "description": "Mixed"},
                          ],
                        );
                      }
                    })(),
                  ),
                  const CustomFormDropDownFieldWidget(
                    // label: "Exploration Days",
                    label: "Destination Option",
                    data: [
                      {"code": "1", "description": "All included"},
                      {"code": "2", "description": "Leisure Time"},
                      {"code": "3", "description": "Foods Included"},
                      {"code": "4", "description": "Open Credit"},
                    ],
                  ),
                  const CustomFormDropDownFieldWidget(
                    // label: "Exploration Days",
                    label: "Travel Rithm             ",
                    data: [
                      {"code": "1", "description": "Soft"},
                      {"code": "2", "description": "Medium"},
                      {"code": "3", "description": "Hard"},
                      // {"code": "2", "description": "hola 2"},
                    ],
                  ),
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
