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
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.1),
          child: SizedBox(
            child: Column(children: [
              CustomTitleWidget(
                width: 0.2,
                fontWeight: FontWeight.bold,
                label: destinations[destination][1],
              ),
              CustomFormDropDownFieldWidget(
                onSaved: (value) {},
                onChanged: (value) {},
                label: "Exploration Days     ",
                data: const [
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
                    return CustomFormDropDownFieldWidget(
                      onSaved: (value) {},
                       onChanged: (value) {},
                      label: "Exploration Mode   ",
                      data: const [
                        {"code": "1", "description": "Cruiser"},
                        {"code": "2", "description": "Hop Island"},
                        {"code": "3", "description": "Mixed"},
                      ],
                    );
                  }
                })(),
              ),
              CustomFormDropDownFieldWidget(
                // label: "Exploration Days",
                onSaved: (value) {},
                 onChanged: (value) {},
                label: "Destination Option",
                data: const [
                  {"code": "1", "description": "All included"},
                  {"code": "2", "description": "Leisure Time"},
                  {"code": "3", "description": "Foods Included"},
                  {"code": "4", "description": "Open Credit"},
                ],
              ),
              CustomFormDropDownFieldWidget(
                // label: "Exploration Days",
                onSaved: (value) {},
                 onChanged: (value) {},
                label: "Travel Rithm             ",
                data: const [
                  {"code": "1", "description": "Soft"},
                  {"code": "2", "description": "Medium"},
                  {"code": "3", "description": "Hard"},
                  // {"code": "2", "description": "hola 2"},
                ],
              ),
              const CustomFormMultiDropDownFieldWidget(
                // label: "Exploration Days",
                hintText: " ",
                label: "Key Activities            ",
                data: [
                  {"code": "1", "description": "Adventure"},
                  {"code": "2", "description": "Culture"},
                  {"code": "3", "description": "History"},
                  {"code": "4", "description": "Education"},
                  {"code": "5", "description": "Culinary"},
                  {"code": "6", "description": "Nature"},
                  {"code": "7", "description": "Wellness"},
                  {"code": "8", "description": "Surprise"},
                  {"code": "9", "description": "Romance"},
                  // {"code": "2", "description": "hola 2"},
                ],
              ),
              const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            ]),
          ),
        ),
      ],
    );
  }
}
