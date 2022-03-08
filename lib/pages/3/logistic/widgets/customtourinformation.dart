import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/validators.dart';
import '../../../index.dart';
import '../index.dart';

class CustomLogisticInformationForm extends StatelessWidget {
  CustomLogisticInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final LogisticController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var readonly = getContext("readonly") ?? false;
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.16,
              left: MediaQuery.of(context).size.width * 0.54,
            ),
            child: Column(
              children: [
                const CustomTitleWidget(
                  width: 0.3,
                  fontWeight: FontWeight.bold,
                  label: "  Logistic Information",
                ),
                SingleChildScrollView(
                  child: Column(children: [
                    Obx(() {
                      return Column(
                        children: [
                          CustomFormDropDownFieldWidget(
                            validator: CustomRequiredValidator(
                                errorText: "Destination option is required ",
                                ctx: context),
                            value: tourOption.value,
                            onSaved: (value) {
                              setFormValue(globalctx.memory, "logistic",
                                  "tour_option", value);
                            },
                            onChanged: (value) {
                              setFormValue(globalctx.memory, "logistic",
                                  "tour_option", value);
                              tourOption.value = value!;
                            },
                            label: "Tour Options\t\t\t\t\t\t\t\t\t\t\t\t\t",
                            data: processCatalog("destination_option"),
                          ),
                          if (tourOption.value == "4")
                            CustomFormDropDownFieldWidget(
                              validator: CustomRequiredValidator(
                                  errorText: "Open Credit is required ",
                                  ctx: context),
                              value: getFormValue(globalctx.memory, "logistic",
                                  "open_credit", "0"),
                              onSaved: (value) {
                                setFormValue(globalctx.memory, "logistic",
                                    "open_credit", value);
                              },
                              onChanged: (value) {
                                setFormValue(globalctx.memory, "logistic",
                                    "open_credit", value);
                              },
                              label: "Open Credit Options ",
                              data: processCatalog("open_credit"),
                            ),
                          if (tourOption.value == "2")
                            Column(
                              children: [
                                CustomFormDateFieldWidget(
                                  disabled: readonly,
                                  initialValue: sinceDate.value,
                                  validator: CustomDatetimeGreaterValidator(
                                      context: context,
                                      compare: sinceDate.value,
                                      errorText:
                                          "There is a problem with the Range Date",
                                      invert: false),
                                  label: "Since Date\t\t\t\t\t\t\t\t\t\t\t\t\t",
                                  onSaved: (value) {
                                    ctrl!.state.sinceDate = value!;
                                    sinceDate.value = value;
                                  },
                                  onChanged: (value) {
                                    value ??= DateTime.now();
                                    ctrl!.state.sinceDate = value;
                                    sinceDate.value = value;
                                  },
                                ),
                                CustomFormDateFieldWidget(
                                  disabled: readonly,
                                  initialValue: untilDate.value,
                                  validator: CustomDatetimeGreaterValidator(
                                      context: context,
                                      compare: untilDate.value,
                                      errorText:
                                          "There is a problem with the Range Date",
                                      invert: true),
                                  label:
                                      "Until Date\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                                  onSaved: (value) {
                                    ctrl!.state.untilDate = value!;
                                    untilDate.value = value;
                                  },
                                  onChanged: (value) {
                                    value ??= DateTime.now();
                                    ctrl!.state.untilDate = value;
                                    untilDate.value = value;
                                  },
                                )
                              ],
                            ),
                        ],
                      );
                    }),
                    const CustomTitleWidget(
                        width: 0.225,
                        fontWeight: FontWeight.bold,
                        label: "  Arrival information"),
                    CustomFormDropDownFieldWidget(
                      value: arrivalPort.value,
                      disabled: readonly,
                      onSaved: (value) {
                        ctrl!.state.arrival_port = value!;
                        setFormValue(globalctx.memory, "logistic",
                            "arrival_port", value);
                        arrivalPort.value = value;
                      },
                      onChanged: (value) {
                        ctrl!.state.arrival_port = value!;
                      },
                      validator: CustomRequiredValidator(
                          errorText: "Arrival Port is required ", ctx: context),
                      label: "Arrival Port\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                      data: airportCatalog.toList(),
                    ),
                    Obx(() {
                      return CustomFormDateFieldWidget(
                        disabled: readonly,
                        initialValue: arrivalDate.value,
                        validator: CustomDatetimeGreaterValidator(
                            context: context,
                            compare: departureDate.value,
                            errorText:
                                "There is a problem with the Departure Date"),
                        label: "Arrival Date               ",
                        onSaved: (value) {
                          ctrl!.state.arrivalDate = value!;
                          arrivalDate.value = value;
                        },
                        onChanged: (value) {
                          value ??= DateTime.now();
                          ctrl!.state.arrivalDate = value;
                          arrivalDate.value = value;
                        },
                      );
                    }),
                    const CustomTitleWidget(
                        width: 0.225,
                        fontWeight: FontWeight.bold,
                        label: "  Departure information"),
                    CustomFormDropDownFieldWidget(
                      value: departurePort.value,
                      disabled: readonly,
                      onSaved: (value) {
                        ctrl!.state.departure_port = value!;
                        setFormValue(globalctx.memory, "logistic",
                            "departure_port", value);
                        departurePort.value = value;
                      },
                      onChanged: (value) {
                        ctrl!.state.departure_port = value!;
                      },
                      validator: CustomRequiredValidator(
                          errorText: "Departure Port is required ",
                          ctx: context),
                      label: "Departure Port            ",
                      data: airportCatalog.toList(),
                    ),
                    Obx(() {
                      return CustomFormDateFieldWidget(
                        disabled: readonly,
                        initialValue: departureDate.value,
                        validator: CustomDatetimeGreaterValidator(
                            context: context,
                            compare: arrivalDate.value,
                            errorText:
                                "There is a problem with the Arrival Date",
                            invert: true),
                        label: "Departure Date       ",
                        onSaved: (value) {
                          ctrl!.state.departureDate = value!;
                          departureDate.value = value;
                        },
                        onChanged: (value) {
                          value ??= DateTime.now();
                          ctrl!.state.departureDate = value;
                          departureDate.value = value;
                        },
                      );
                    }),
                  ]),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.815,
            left: MediaQuery.of(context).size.width * 0.56,
          ),
          child: CustomKeypadWidget(
              width: 0.265,
              onPrevious: () {
                selectedIndex.value = selectedIndex.value - 1;
                Get.back();
              },
              onNext: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ctrl!.saveLogistic();
                  selectedIndex.value = selectedIndex.value + 1;
                }
              }),
        ),
      ],
    );
  }
}
