import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/index.dart';

class CustomLogisticInformationForm extends StatelessWidget {
  CustomLogisticInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final LogisticController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var readonly = getContext("readonly") ?? false;
    var galapagos =
        Rx(getFormValue(globalctx.memory, "tour", "galapagos", false));
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.16,
                left: MediaQuery.of(context).size.width * 0.54,
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      Obx(() {
                        if (galapagos.value) {
                          return Row(
                            children: [
                              const CustomTitleWidget(
                                  width: 0.225,
                                  fontWeight: FontWeight.bold,
                                  label: "  Cruise information     "),
                              RoundedFormButton(
                                color: Colors.grey,
                                label: "View Cruise Calendar",
                                height: 0.05,
                                fontSize: 3,
                                fontWeight: FontWeight.bold,
                                textColor:
                                    cruiseDay.value.isEmpty || cruiseEdit.value
                                        ? Colors.black
                                        : Colors.black54,
                                onPressed: () async {
                                  if (cruiseDay.value.isEmpty ||
                                      cruiseEdit.value) {
                                    showCustomDialog(
                                        context,
                                        CruiseCalendarWidget(ctx: context),
                                        "Close",
                                        customChild: CruiseKeyPadWidget(),
                                        backgroundColor: Colors.white,
                                        buttonColor: Colors.black,
                                        height: 0.25,
                                        width: 0.2);
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
                          resetAllDestinations();
                        },
                        onChanged: (value) {
                          ctrl!.state.arrival_port = value!;
                        },
                        validator: CustomRequiredValidator(
                            errorText: "Arrival Port is required ",
                            ctx: context),
                        label: "Arrival Port\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                        data: airportCatalog.toList(),
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            CustomFormDateFieldWidget(
                              disabled: (readonly || cruiseDay.isNotEmpty) &&
                                  !arrivalEdit.value,
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
                            CheckboxIconFormField(
                                padding: 0,
                                initialValue: arrivalEdit.value,
                                onChanged: (value) {
                                  arrivalEdit.value = !arrivalEdit.value;
                                })
                          ],
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
                          departurePort.value = value;
                          resetAllDestinations();
                        },
                        validator: CustomRequiredValidator(
                            errorText: "Departure Port is required ",
                            ctx: context),
                        label: "Departure Port            ",
                        data: airportCatalog.toList(),
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            CustomFormDateFieldWidget(
                              disabled: (readonly || cruiseDay.isNotEmpty) &&
                                  !departureEdit.value,
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
                                filterCruises(context);
                              },
                              onChanged: (value) {
                                value ??= DateTime.now();
                                ctrl!.state.departureDate = value;
                                departureDate.value = value;
                                filterCruises(context);
                              },
                            ),
                            CheckboxIconFormField(
                                padding: 0,
                                initialValue: departureEdit.value,
                                onChanged: (value) {
                                  departureEdit.value = !departureEdit.value;
                                })
                          ],
                        );
                      }),
                      Obx(() {
                        return Column(
                          children: [
                            const CustomTitleWidget(
                              width: 0.3,
                              fontWeight: FontWeight.bold,
                              label: "  Logistic Information",
                            ),
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
                              data: findCatalog("tour_option"),
                            ),
                            Row(
                              children: [
                                CustomFormCheckboxWidget(
                                  label: "Open Credit                 ",
                                  value: 1,
                                  groupValue: openBoolCredit,
                                  onChanged: (value) {
                                    openBoolCredit.value = value;
                                    setFormValue(globalctx.memory, "logistic",
                                        "open_credit", value);
                                  },
                                ),
                              ],
                            ),
                            if (openBoolCredit.value == 1)
                              CustomFormCounterFieldWidget(
                                  initial: openCredit.value,
                                  min: 0,
                                  max: 5000,
                                  step: 100,
                                  original: true,
                                  onValueChanged: (value) {
                                    try {
                                      if (value! > 0) {
                                        openCredit.value = value as int;
                                        setFormValue(
                                            globalctx.memory,
                                            "logistic",
                                            "open_credit_value",
                                            value);
                                      }
                                    } catch (e) {
                                      log(e);
                                    }
                                  },
                                  label: '\t\tOpen Credit Amount',
                                  width: 0.2),
                            if (cruiseDay.isNotEmpty)
                              CustomTitleWidget(
                                width: 0.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                label:
                                    "  Remember you have selected  ${cruiseDay.value} days of Galapagos Cruise !!!!",
                              ),
                          ],
                        );
                      }),
                    ]),
                  ),
                ],
              ),
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
                goto("Tour");
              },
              onNext: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ctrl!.saveLogistic();
                }
              }),
        ),
      ],
    );
  }
}
