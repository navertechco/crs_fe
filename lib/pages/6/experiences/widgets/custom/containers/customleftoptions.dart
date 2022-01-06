import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../index.dart';

class CustomLeftOptionsWidget extends StatelessWidget {
  const CustomLeftOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxMap<dynamic, dynamic> localdata =
        globalctx.context.value["experiencedata"];
    var travelOptions = processCatalog("destination_option");
    var keyActivities = processCatalog("key_activity");
    var travelRhythm = processCatalog("travel_rhythm");
    var transportService = processCatalog("service_type");
    var translateService = processCatalog("translate_service");
    Rx<int> val = Rx(0);
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "Day 2: Options",
          ),
          Divider(color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomFormMultiDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: [],
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "                  Services",
                      data: transportService,
                    ),
                    CustomFormMultiDropDownFieldWidget(
                      // label: "Exploration Days",
                      value: [],
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "                  Translator",
                      data: translateService,
                    ),
                    CustomFormCheckboxWidget(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        if (val.value == value) {
                          val.value = 0;
                        } else {
                          val.value = value;
                        }
                      },
                      hintText: "Driver guide?",
                    ),
                     CustomFormCheckboxWidget(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        if (val.value == value) {
                          val.value = 0;
                        } else {
                          val.value = value;
                        }
                      },
                      hintText: "Additional guide?",
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Travel Options",
                      data: travelOptions,
                    ),
                    CustomFormMultiDropDownFieldWidget(
                      value: [
                        {"code": "1", "description": "Adventure"}
                      ],
                      onSaved: (value) {},
                      onChanged: (value) {
                        // setData(localdata[experience],"key_activities", value);
                      },
                      hintText: "Key Activities            ",
                      data: keyActivities,
                    ),
                    CustomFormDropDownFieldWidget(
                      // label: "Exploration Days",
                      onSaved: (value) {},
                      onChanged: (value) {},
                      hintText: "Travel Rhythm",
                      data: travelRhythm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
