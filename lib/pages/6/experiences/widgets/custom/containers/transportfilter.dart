import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/leftHeader.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/travelchip.dart';
import '../../../../../index.dart';
import '../../../controller.dart';

class TransportFilter extends HookWidget {
  TransportFilter(
      {Key? key, required this.ctrl, this.counter, required this.formKey})
      : super(key: key);
  GlobalKey<FormState> formKey;
  final ExperiencesController ctrl;
  final counter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0,
        left: MediaQuery.of(context).size.width * 0.6,
      ),
      child: BodyWidget(ctrl: ctrl, counter: counter, formKey: formKey),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({Key? key, this.ctrl, this.counter, required this.formKey})
      : super(key: key);
  final ctrl;
  final counter;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var index = getDestinationIndex(
          globalDestinationName.value, globalDestinationType.value);
      Rx<bool> customGuide = Rx(getFormValue(
          globalctx.memory["destinations"], index, "customGuide", false));

      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.08,
          ),
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  LeftInfoHeader(
                      fontSize: 15,
                      header: LeftHeader(
                          fontSize: 17, ctrl: ctrl, counter: counter)),
                  LeftDayOptions(
                      customGuide: customGuide,
                      index: index,
                      ctrl: ctrl,
                      counter: counter),
                ],
              )),
        ),
      );
    });
  }
}

class LeftDayOptions extends StatelessWidget {
  const LeftDayOptions({
    Key? key,
    required this.customGuide,
    required this.index,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  final Rx<bool> customGuide;
  final index;
  final ctrl;
  final counter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.25,
        left: MediaQuery.of(context).size.width * 0.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (globalDestinationName.value == "galapagos")
              Row(
                children: [
                  CustomTitleWidget(
                      fontWeight: FontWeight.bold,
                      label: "Custom Additional guide:",
                      color: Colors.white),
                  CheckboxIconFormField(
                    context: context,
                    initialValue: customGuide.value,
                    enabled: true,
                    iconSize: 32,
                    onSaved: (value) {
                      setFormValue(globalctx.memory["destinations"], index,
                          "customGuide", value);
                    },
                    onChanged: (value) {
                      customGuide.value = value;
                      setFormValue(globalctx.memory["destinations"], index,
                          "customGuide", value);
                    },
                  ),
                ],
              ),
            TravelChips(ctrl: ctrl, counter: counter),
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Day Transport Options:",
                color: Colors.white),
            CustomFormMultiDropDownFieldWidget(
              validator: (value) => CustomMultiDropdownRequiredValidator(value,
                  errorText: "Day Transport Options are required ",
                  context: context),
              value: getFormValue(globalctx.memory["destinations"],
                  globalDestinationIndex.value, "service_type", ["DRIVING"]),
              onSaved: (values) {
                transportService.value = values;
                openGuide.value = transportService.value.contains(3);
                openTranslate.value = transportService.value.contains(2);
                multiSaving(
                    values,
                    "service_type",
                    globalctx.memory["destinations"],
                    index,
                    "service_type",
                    transportService);
              },
              onChanged: (value) {
                transportService.value = value;
                openGuide.value = transportService.value.contains(3);
                openTranslate.value = transportService.value.contains(2);
                setFormValue(globalctx.memory["destinations"],
                    globalDestinationIndex.value, "service_type", value);
              },
              hintText: "                  Services\n",
              data: serviceTypeCatalog.value,
            ),
            if (openTranslate.value)
              CustomFormMultiDropDownFieldWidget(
                validator: (value) => CustomMultiDropdownRequiredValidator(
                    value,
                    errorText: "Translating Service is required ",
                    context: context),
                value: translatingService.value ?? <String>[],
                onSaved: (value) {
                  setFormValue(
                      globalctx.memory["destinations"],
                      globalDestinationIndex.value,
                      "translating_service",
                      value);
                },
                onChanged: (value) {
                  openTranslate.value = false;
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
            if (openGuide.value)
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
                        setFormValue(globalctx.memory["destinations"],
                            globalDestinationIndex.value, "guide_type", value);
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
                        setFormValue(globalctx.memory["destinations"],
                            globalDestinationIndex.value, "guide_type", value);
                      }
                    },
                    hintText: "Additional guide?",
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class LeftInfoHeader extends StatelessWidget {
  const LeftInfoHeader({
    Key? key,
    required this.header,
    required this.fontSize,
  }) : super(key: key);
  final LeftHeader header;
  final int fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.0),
      child: Column(children: [
        header,
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label:
                "Current Day: ${dayFormat.format(currentDate.value).replaceAll(" ", "-")}",
            color: Colors.white,
            fontSize: fontSize),
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label:
                "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}",
            color: Colors.white,
            fontSize: fontSize),
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label:
                "Accumulated Hours: ${getTimeStringFromDouble(getRXValue(accumulatedHours, currentDay.value, 0.0))}",
            color: Colors.white,
            fontSize: fontSize),
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label:
                "Left Hours: ${getTimeStringFromDouble(getRXValue(leftHours, currentDay.value, getMaxTrValue(currentTravelRhythm.value)))}",
            color: Colors.white,
            fontSize: fontSize),
      ]),
    );
  }
}
