// ignore_for_file: invalid_use_of_protected_member

import 'package:checkbox_formfield/checkbox_icon_formfield.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class CustomTourInformationForm extends StatelessWidget {
  CustomTourInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final TourController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tourdata = globalctx["memory"];
    var tour = getValue(tourdata, "tour");
    var readonly = getContext("readonly") ?? false;
    var purposes = findCatalog("purposes");
    var accomodationType = findCatalog("budget");

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.18,
          left: MediaQuery.of(context).size.width * 0.54,
        ),
        child: SizedBox(
          child: Stack(
            children: [
              Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const CustomTitleWidget(
                    width: 0.225,
                    fontWeight: FontWeight.bold,
                    label: "  Tour information"),
                CustomFormDropDownFieldWidget(
                  value: destCountry.value,
                  disabled: readonly,
                  validator: CustomRequiredValidator(
                      errorText: "country is required ", ctx: context),
                  onSaved: (value) {
                    ctrl!.state.country = value!;
                    destCountry.value = value;
                    updateDestinationsCatalogFilteredByCountry();
                  },
                  onChanged: (value) {
                    ctrl!.state.country = value!;
                    destCountry.value = value;
                    updateDestinationsCatalogFilteredByCountry();
                  },
                  label: "Destination Country ",
                  data: destinationCountry,
                ),
                CustomFormDropDownFieldWidget(
                  value: getValue(tour, "accomodation_type", def: "1"),
                  disabled: readonly,
                  onSaved: (value) {
                    ctrl!.state.accomodation_type = value!;
                  },
                  onChanged: (value) {
                    ctrl!.state.accomodation_type = value!;
                  },
                  validator: CustomRequiredValidator(
                      errorText: "Accomodation type is required ",
                      ctx: context),
                  label: "Accomodation Type",
                  data: accomodationType,
                ),
                CustomFormCounterFieldWidget(
                    initial: getFormValue(
                        globalctx["memory"], "tour", "passengers", 1),
                    min: 1,
                    max: 50,
                    bound: 0,
                    onValueChanged: (value) {
                      ctrl!.state.passengers = value! as int;
                      setFormValue(globalctx["memory"], "tour", "passengers",
                          value as int);
                    },
                    label: "  Passengers\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                    width: 0.20),
                Obx(() {
                  return AbsorbPointer(
                    absorbing: absorvedPurpose.value,
                    child: CustomFormMultiDropDownFieldWidget(
                      validator: (value) {
                        CustomMultiDropdownRequiredValidator(value,
                            errorText: "Purposes are required ",
                            context: context);
                      },
                      value: purposeMemory.value,
                      enabled: purposeMemory.value.length < 4,
                      onSaved: (values) {
                        purposeValidate(values);
                      },
                      onChanged: (values) {
                        purposeValidate(values);
                      },
                      hintText: " ",
                      label: "Purposes                      ",
                      data: purposes,
                    ),
                  );
                }),
                Row(
                  children: [
                    CustomTitleWidget(
                        fontWeight: FontWeight.bold,
                        label: "  Would you like to take a Galapagos Cruise?",
                        color: Colors.black),
                    CheckboxIconFormField(
                      context: context,
                      trueIconColor: Colors.green,
                      initialValue: getFormValue(
                          globalctx["memory"], "tour", "galapagos", false),
                      enabled: true,
                      iconSize: 32,
                      onSaved: (value) {
                        setFormValue(
                            globalctx["memory"], "tour", "galapagos", value);
                      },
                      onChanged: (value) {
                        setFormValue(
                            globalctx["memory"], "tour", "galapagos", value);
                      },
                    ),
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.635,
                  left: MediaQuery.of(context).size.width * 0.022,
                ),
                child: CustomKeypadWidget(
                    width: 0.265,
                    onPrevious: () {
                      if (selectedIndex.value > 0) {
                        selectedIndex.value = selectedIndex.value - 1;
                      }

                      Get.back();
                    },
                    onNext: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ctrl!.sendTour();
                        selectedIndex.value = selectedIndex.value + 1;
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
