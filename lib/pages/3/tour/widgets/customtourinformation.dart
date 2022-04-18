// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../../../index.dart';

class CustomTourInformationForm extends StatelessWidget {
  CustomTourInformationForm({Key? key, this.profile, this.ctrl})
      : super(key: key);

  final bool? profile;
  final TourController? ctrl;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tourdata = globalctx.memory;
    var tour = getValue(tourdata, "tour");
    var readonly = getContext("readonly") ?? false;
    var purpose = processCatalog("purpose");
    var accomodationType = processCatalog("budget");

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.18,
          left: MediaQuery.of(context).size.width * 0.54,
        ),
        child: SizedBox(
          child: Column(children: [
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
                updateDestinationsCatalog();
              },
              onChanged: (value) {
                ctrl!.state.country = value!;
                destCountry.value = value;
                updateDestinationsCatalog();
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
                  errorText: "Accomodation type is required ", ctx: context),
              label: "Accomodation Type",
              data: accomodationType,
            ),
            CustomFormTextFieldWidget(
                disabled: readonly,
                value: getValue(tour, "passengers", def: "10"),
                validator: CustomRequiredValidator(
                    errorText: "Passengers is required ", ctx: context),
                onSaved: (value) {
                  ctrl!.state.passengers = value!;
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                label: "Passengers                  ",
                width: 0.20),
            Obx(() {
              return CustomFormMultiDropDownFieldWidget(
                validator: (value) => CustomMultiDropdownRequiredValidator(
                    value,
                    errorText: "Purposes are required ",
                    context: context),
                value: purposeMemory.value,
                onSaved: (values) {
                  if (values == null) return;
                  if (values.length > 3) {
                    Get.snackbar("Error", "You can select maximum 3 purposes",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        borderRadius: 10,
                        margin: EdgeInsets.all(10),
                        duration: Duration(seconds: 3));
                    return;
                  }
                  if (values.length <= 3) {
                    purposeMemory.value = [];
                    var length = values.length;

                    for (var i = 0; i < length; i++) {
                      purposeMemory.value.add(purpose
                          .toList()
                          .where((e) => e["code"] == values[i])
                          .toList()[0]["description"]);
                    }
                  }
                },
                onChanged: (values) {
                  if (values == null) return;
                  purposeMemory.value = values;
                },
                hintText: " ",
                label: "Purposes                      ",
                data: purpose,
              );
            }),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.17,
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
                      ctrl!.saveTour();
                      selectedIndex.value = selectedIndex.value + 1;
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
