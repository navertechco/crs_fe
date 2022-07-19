import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class CustomLogisticInformationForm extends StatelessWidget {
  CustomLogisticInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final LogisticController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LogisticForm(formKey: _formKey, ctrl: ctrl),
        LogisticKeyPad(formKey: _formKey, ctrl: ctrl),
      ],
    );
  }
}

class LogisticForm extends StatelessWidget {
  const LogisticForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final LogisticController? ctrl;

  @override
  Widget build(BuildContext context) {
    var readonly = getContext("readonly") ?? false;
    var galapagosCruise =
        Rx(getFormValue(globalctx.memory, "tour", "galapagos_cruise", false));
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * isMobile * 0.165,
            left: MediaQuery.of(context).size.width * isMobile * 0.55,
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(children: [
                  Obx(() {
                    var label = Rx(getFormValue(globalctx.memory, "logistic",
                        "cruiseName", "View Cruise Calendar"));
                    if (galapagosCruise.value) {
                      return Row(
                        children: [
                          CustomTitleWidget(
                              width: isMobile * 0.225,
                              fontWeight: FontWeight.bold,
                              label: "  Cruise information     "),
                          RoundedFormButton(
                            height: 0.06,
                            color: Colors.grey,
                            label: label.value,
                            fontSize: 6,
                            fontWeight: FontWeight.bold,
                            textColor:
                                cruiseDay.value == "0" || cruiseEdit.value
                                    ? Colors.black
                                    : Colors.black54,
                            onPressed: () async {
                              if (cruiseDay.value == "0" || cruiseEdit.value) {
                                showCustomDialog(context,
                                    CruiseCalendarWidget(ctx: context), "Close",
                                    customChild: CruiseKeyPadWidget(),
                                    backgroundColor: Colors.white,
                                    buttonColor: Colors.black,
                                    height: 0.25,
                                    width: 0.8);
                              }
                            },
                          ),
                          CheckboxIconFormField(
                              padding: 0,
                              initialValue: cruiseEdit.value,
                              onChanged: (value) {
                                cruiseEdit.value = !cruiseEdit.value;
                              })
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  Row(
                    children: [
                      if (cruiseDay.value != "0")
                        CustomTitleWidget(
                          fontSize: 8,
                          width: 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          label:
                              "Sails: ${currentDayFormat.format(cruiseStartDate.value)} -> Lands: ${currentDayFormat.format(cruiseEndDate.value)}",
                        ),
                    ],
                  ),
                  CustomTitleWidget(
                      fontSize: 10,
                      width: isMobile * 0.225,
                      fontWeight: FontWeight.bold,
                      label: "Arrival information"),
                  CustomFormDropDownFieldWidget(
                    height: 0.05,
                    fontSize: 10,
                    value: getFormValue(
                        globalctx.memory, "logistic", "arrival_port", "0"),
                    disabled: readonly,
                    onSaved: (value) {
                      ctrl!.state.arrival_port = value!;
                      arrivalPort.value = value;
                      setFormValue(
                          globalctx.memory, "logistic", "arrival_port", value);
                      resetAllDestinations();
                    },
                    onChanged: (value) {
                      ctrl!.state.arrival_port = value!;
                      arrivalPort.value = value;
                      setFormValue(
                          globalctx.memory, "logistic", "arrival_port", value);
                    },
                    validator: CustomRequiredValidator(
                        errorText: "Arrival Port is required ", ctx: context),
                    label: "Arrival Port                    ",
                    data: airportCatalog
                        .where((element) => element["value"]["type"] != "out")
                        .toList(),
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        if (cruiseDay.value == "0")
                          CustomFormDateFieldWidget(
                            height: 0.06,
                            width: 0.2,
                            fontSize: 10,
                            disabled: (readonly || cruiseDay.value != "0") &&
                                !arrivalEdit.value,
                            initialValue: arrivalDate.value,
                            validator: CustomDatetimeGreaterValidator(
                                context: context,
                                compare: departureDate.value,
                                errorText:
                                    "There is a problem with the Departure Date"),
                            label: "Arrival Date                  ",
                            onSaved: (value) {
                              ctrl!.state.arrivalDate = value!;
                              arrivalDate.value = value;
                              // clearCruiseFilter();
                              filterCruises(context);
                            },
                            onChanged: (value) {
                              value ??= DateTime.now();
                              ctrl!.state.arrivalDate = value;
                              arrivalDate.value = value;
                              filterCruises(context);
                            },
                          ),
                        if (cruiseDay.value != "0")
                          Row(
                            children: [
                              CustomTitleWidget(
                                  fontSize: 10,
                                  width: isMobile * 0.225,
                                  fontWeight: FontWeight.bold,
                                  label:
                                      "  Arrival Date                            "),
                              CustomTitleWidget(
                                  fontSize: 10,
                                  width: isMobile * 0.225,
                                  fontWeight: FontWeight.bold,
                                  label: currentDayFormat
                                      .format(arrivalDate.value)),
                            ],
                          ),
                        // CheckboxIconFormField(
                        //     padding: 0,
                        //     initialValue: arrivalEdit.value,
                        //     onChanged: (value) {
                        //       arrivalEdit.value = !arrivalEdit.value;
                        //     })
                      ],
                    );
                  }),
                  CustomTitleWidget(
                      fontSize: 10,
                      width: isMobile * 0.225,
                      fontWeight: FontWeight.bold,
                      label: "  Departure information"),
                  CustomFormDropDownFieldWidget(
                    height: 0.05,
                    fontSize: 10,
                    value: getFormValue(
                        globalctx.memory, "logistic", "departure_port", "0"),
                    disabled: readonly,
                    onSaved: (value) {
                      ctrl!.state.departure_port = value!;
                      departurePort.value = value;
                      setFormValue(globalctx.memory, "logistic",
                          "departure_port", value);
                      resetAllDestinations();
                    },
                    onChanged: (value) {
                      ctrl!.state.departure_port = value!;
                      departurePort.value = value;
                      setFormValue(globalctx.memory, "logistic",
                          "departure_port", value);
                    },
                    validator: CustomRequiredValidator(
                        errorText: "Departure Port is required ", ctx: context),
                    label: "Departure Port            ",
                    data: airportCatalog.where((element) {
                      var rule = true;
                      rule = rule && element["value"]["type"] != "in";
                      if (element["description"] == "GALAPAGOS") {
                        rule = galapagosCruise.value;
                      }
                      return rule;
                    }).toList(),
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        if (cruiseDay.value == "0")
                          CustomFormDateFieldWidget(
                            fontSize: 10,
                            disabled: false,
                            initialValue: departureDate.value,
                            validator: CustomDatetimeGreaterValidator(
                                context: context,
                                compare: arrivalDate.value,
                                errorText:
                                    "There is a problem with the Arrival Date",
                                invert: true),
                            label: "Departure Date           ",
                            onSaved: (value) {
                              ctrl!.state.departureDate = value!;
                              departureDate.value = value;
                              totalDays.value = departureDate.value
                                  .difference(arrivalDate.value)
                                  .inDays;
                              filterCruises(context);
                            },
                            onChanged: (value) {
                              value ??= DateTime.now();
                              ctrl!.state.departureDate = value;
                              departureDate.value = value;
                              totalDays.value = departureDate.value
                                  .difference(arrivalDate.value)
                                  .inDays;
                              filterCruises(context);
                            },
                          ),
                        if (cruiseDay.value != "0")
                          Row(
                            children: [
                              CustomTitleWidget(
                                  fontSize: 10,
                                  width: isMobile * 0.225,
                                  fontWeight: FontWeight.bold,
                                  label: "  Departure Date                   "),
                              CustomTitleWidget(
                                  fontSize: 10,
                                  width: isMobile * 0.225,
                                  fontWeight: FontWeight.bold,
                                  label: currentDayFormat
                                      .format(departureDate.value)),
                            ],
                          ),
                        // CheckboxIconFormField(
                        //     padding: 0,
                        //     initialValue: departureEdit.value,
                        //     onChanged: (value) {
                        //       departureEdit.value = !departureEdit.value;
                        //     })
                      ],
                    );
                  }),
                  Obx(() {
                    return Column(
                      children: [
                        const CustomTitleWidget(
                          fontSize: 10,
                          width: 0.3,
                          fontWeight: FontWeight.bold,
                          label: "Logistic Information",
                        ),
                        CustomFormDropDownFieldWidget(
                          height: 0.05,
                          fontSize: 10,
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
                          label: "Tour Options                ",
                          data: findCatalog("tour_option"),
                        ),
                        Row(
                          children: [
                            const CustomTitleWidget(
                              fontSize: 10,
                              width: 0.3,
                              fontWeight: FontWeight.bold,
                              label: "   Open Credit  ",
                            ),
                            CheckboxIconFormField(
                              padding: 0,
                              initialValue: openBoolCredit.value,
                              onChanged: (value) {
                                openBoolCredit.value = !openBoolCredit.value;
                                setFormValue(globalctx.memory, "logistic",
                                    "open_credit", value);
                              },
                            ),
                            if (openBoolCredit.value)
                              CustomFormTextFieldWidget(
                                height: 0.05,
                                fontSize: 10,
                                value: getFormValue(globalctx.memory,
                                    "logistic", "open_credit_value", "100"),
                                onChanged: (value) {
                                  setFormValue(globalctx.memory, "logistic",
                                      "open_credit_value", value);
                                },
                                label: "",
                                width: 0.2,
                                onSaved: (value) {},
                              ),
                          ],
                        ),
                        if (cruiseDay.value != "0")
                          Row(
                            children: [
                              CustomTitleWidget(
                                fontSize: 8,
                                width: 0.1,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                label:
                                    "Remember you have selected  ${cruiseDay.value} days of Galapagos Cruise",
                              ),
                            ],
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2)
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogisticKeyPad extends StatelessWidget {
  const LogisticKeyPad({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final LogisticController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.802,
        left: MediaQuery.of(context).size.width * 0.555,
      ),
      child: CustomKeypadWidget(
          fontSize: 10,
          width: 0.25,
          onPrevious: () {
            gotoPage("Tour");
          },
          onNext: () {
            var cruise = getFormValue(
                globalctx.memory, "tour", "galapagos_cruise", false);
            if (_formKey.currentState!.validate()) {
              if (cruiseDay.value == "0" && cruise) {
                SweetAlertV2.show(context,
                    curve: ElasticInCurve(),
                    title: "Cruise information is Required",
                    style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
                  Get.close(1);
                  return false;
                });
              } else {
                _formKey.currentState!.save();
                ctrl!.saveLogistic();
              }
            }
          }),
    );
  }
}
