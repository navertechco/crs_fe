import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/leftHeader.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/travelchip.dart';
import '../../../../../index.dart';
import '../../../controller.dart';

class TransportFilter extends HookWidget {
  const TransportFilter({Key? key, required this.ctrl, this.counter})
      : super(key: key);

  final ExperiencesController ctrl;
  final counter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0,
        left: MediaQuery.of(context).size.width * 0.6,
      ),
      child: BodyWidget(ctrl: ctrl, counter: counter),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key, this.ctrl, this.counter}) : super(key: key);
  final ctrl;
  final counter;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var index = getDestinationIndex(
          globalDestinationName.value, globalDestinationType.value);

      Rx<dynamic> travelRhythm = Rx(getFormValue(
          globalctx.memory["destinations"],
          index,
          "travelRhythm",
          globalDestinationName.value == "galapagos" ? "3" : "1"));
      return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.08,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                LeftHeader(ctrl: ctrl, counter: counter),
                Column(
                  children: [
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label:
                            "Current Day: ${dayFormat.format(currentDate.value).replaceAll(" ", "-")}",
                        color: Colors.white,
                        fontSize: 15),
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label:
                            "Travel Rhythm: ${findTravelRhythmDescription(parseInt(travelRhythm.value))}",
                        color: Colors.white,
                        fontSize: 15),
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label:
                            "Accumulated Hours: ${getTimeStringFromDouble(getRXValue(accumulatedHours, currentDay.value, 0.0))}",
                        color: Colors.white,
                        fontSize: 15),
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label:
                            "Left Hours: ${getTimeStringFromDouble(getRXValue(leftHours, currentDay.value, 6.0))}",
                        color: Colors.white,
                        fontSize: 15),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TravelChips(ctrl: ctrl, counter: counter),
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label: "Day Transport Options:",
                        color: Colors.white),
                    CustomFormMultiDropDownFieldWidget(
                      value: getFormValue(
                              globalctx.memory["destinations"],
                              globalDestinationIndex.value,
                              "service_type", <String>[]) ??
                          <String>[],
                      onSaved: (value) {
                        transportService.value = value;
                        guideIndex.value = transportService.value
                            .indexWhere((element) => element == "GUIDING");
                        translateIndex.value = transportService.value
                            .indexWhere((element) => element == "TRANSLATING");
                        setFormValue(
                            globalctx.memory["destinations"],
                            globalDestinationIndex.value,
                            "service_type",
                            value);
                      },
                      onChanged: (value) {
                        transportService.value = value;
                        guideIndex.value = transportService.value
                            .indexWhere((element) => element == "GUIDING");
                        translateIndex.value = transportService.value
                            .indexWhere((element) => element == "TRANSLATING");
                        setFormValue(
                            globalctx.memory["destinations"],
                            globalDestinationIndex.value,
                            "service_type",
                            value);
                      },
                      hintText: "                  Services\n",
                      data: serviceTypeCatalog.value,
                    ),
                    if (translateIndex.value != -1)
                      CustomFormMultiDropDownFieldWidget(
                        value: translatingService.value ?? <String>[],
                        onSaved: (value) {
                          setFormValue(
                              globalctx.memory["destinations"],
                              globalDestinationIndex.value,
                              "translating_service",
                              value);
                        },
                        onChanged: (value) {
                          translateIndex.value = value!.isNotEmpty ? 0 : -1;
                          translatingService.value = value;
                          setFormValue(
                              globalctx.memory["destinations"],
                              globalDestinationIndex.value,
                              "translating_service",
                              value);
                        },
                        hintText: "          Translating Services",
                        data: translatingCatalog.value,
                      ),
                    if (guideIndex.value != -1)
                      Column(
                        children: [
                          CustomFormCheckboxWidget(
                            value: 1,
                            groupValue: guide,
                            onChanged: (value) {
                              if (guide.value == value) {
                                guide.value = 0;
                              } else {
                                guide.value = value;
                                setFormValue(
                                    globalctx.memory["destinations"],
                                    globalDestinationIndex.value,
                                    "guide_type",
                                    value);
                              }
                            },
                            hintText: "Driver guide?",
                          ),
                          CustomFormCheckboxWidget(
                            value: 2,
                            groupValue: guide,
                            onChanged: (value) {
                              if (guide.value == value) {
                                guide.value = 0;
                              } else {
                                guide.value = value;
                                setFormValue(
                                    globalctx.memory["destinations"],
                                    globalDestinationIndex.value,
                                    "guide_type",
                                    value);
                              }
                            },
                            hintText: "Additional guide?",
                          ),
                        ],
                      )
                  ],
                ),
              ],
            )),
      );
    });
  }
}
