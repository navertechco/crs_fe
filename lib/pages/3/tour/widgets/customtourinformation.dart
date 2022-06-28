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
    var tourdata = globalctx.memory;
    var tour = getValue(tourdata, "tour");
    var readonly = getContext("readonly") ?? false;
    var accomodationType = findCatalog("budget");

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          TourLeftFormWidget(
              readonly: readonly,
              ctrl: ctrl,
              tour: tour,
              accomodationType: accomodationType),
          TourKeyPad(formKey: _formKey, ctrl: ctrl),
        ],
      ),
    );
  }
}

class TourLeftFormWidget extends StatelessWidget {
  const TourLeftFormWidget({
    Key? key,
    required this.readonly,
    required this.ctrl,
    required this.tour,
    required this.accomodationType,
  }) : super(key: key);

  final readonly;
  final TourController? ctrl;
  final tour;
  final List<Map<String, dynamic>> accomodationType;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * isMobile * 0.16,
            left: MediaQuery.of(context).size.width * isMobile * 0.72,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * isMobile * 0.5,
            height: MediaQuery.of(context).size.height * isMobile * 0.65,
            child: SingleChildScrollView(
              child: Column(children: [
                CountryField(readonly: readonly, ctrl: ctrl),
                BudgetField(
                    tour: tour,
                    readonly: readonly,
                    ctrl: ctrl,
                    accomodationType: accomodationType),
                PaxField(ctrl: ctrl),
                CheckboxField(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  label: "  Would you like to take a Galapagos Cruise?",
                  color: Colors.black,
                  trueIconColor: Colors.green,
                  initialValue: getFormValue(
                      globalctx.memory, "tour", "galapagos", false),
                  enabled: true,
                  iconSize: isMobile * 25,
                  onSaved: (value) {
                    setFormValue(globalctx.memory, "tour", "galapagos", value);
                    setFormValue(
                        globalctx.memory, "tour", "galapagos_guide", value);
                  },
                  onChanged: (value) {
                    setFormValue(globalctx.memory, "tour", "galapagos", value);
                    setFormValue(
                        globalctx.memory, "tour", "galapagos_guide", value);
                  },
                ),
                CheckboxField(
                  fontSize: 6,
                  fontWeight: FontWeight.bold,
                  label: "  Would you like to take a Translator?",
                  color: Colors.black,
                  trueIconColor: Colors.green,
                  initialValue: getFormValue(
                      globalctx.memory, "tour", "translator", false),
                  enabled: true,
                  iconSize: isMobile * 25,
                  onSaved: (value) {
                    setFormValue(globalctx.memory, "tour", "translator", value);
                    setFormValue(
                        globalctx.memory, "tour", "translator_guide", value);
                  },
                  onChanged: (value) {
                    translator.value = value;
                    setFormValue(globalctx.memory, "tour", "translator", value);
                    setFormValue(
                        globalctx.memory, "tour", "translator_guide", value);
                  },
                ),
                TransportField(),
                PurposeField(),
                if (translator.value) TranslatingField(),
              ]),
            ),
          ),
        ));
  }
}

class TourKeyPad extends StatelessWidget {
  const TourKeyPad({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TourController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * isMobile * 1,
        left: MediaQuery.of(context).size.width * isMobile * 0.75,
      ),
      child: CustomKeypadWidget(
          width: isMobile * 0.33,
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
    );
  }
}

class CountryField extends StatelessWidget {
  const CountryField({
    Key? key,
    required this.readonly,
    required this.ctrl,
  }) : super(key: key);

  final readonly;
  final TourController? ctrl;

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
      height: 0.07,
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
    );
  }
}

class BudgetField extends StatelessWidget {
  const BudgetField({
    Key? key,
    required this.tour,
    required this.readonly,
    required this.ctrl,
    required this.accomodationType,
  }) : super(key: key);

  final tour;
  final readonly;
  final TourController? ctrl;
  final List<Map<String, dynamic>> accomodationType;

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
      height: 0.07,
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
    );
  }
}

class PaxField extends StatelessWidget {
  const PaxField({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final TourController? ctrl;

  @override
  Widget build(BuildContext context) {
    return CustomFormCounterFieldWidget(
        height: 0.07,
        initial: getFormValue(globalctx.memory, "tour", "passengers", 1),
        min: 1,
        max: 50,
        bound: 0,
        onValueChanged: (value) {
          ctrl!.state.passengers = value! as int;
          setFormValue(globalctx.memory, "tour", "passengers", value as int);
        },
        label: "  Passengers\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
        width: 0.20);
  }
}

class TranslatingField extends StatelessWidget {
  const TranslatingField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomFormMultiDropDownFieldWidget(
          fontSize: 8,
          height: 0.65,
          label: "Translating Services",
          validator: (value) => CustomMultiDropdownRequiredValidator(value,
              errorText: "Translating Service is required ", context: context),
          value: translatingService.value,
          onSaved: (values) {
            saveTranslatingServices(values);
          },
          onChanged: (values) {
            saveTranslatingServices(values);
          },
          hintText: "",
          data: translatingCatalog.value,
        ));
  }
}

class PurposeField extends StatelessWidget {
  const PurposeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AbsorbPointer(
        absorbing: absorvedPurpose.value,
        child: CustomFormMultiDropDownFieldWidget(
          fontSize: 8,
          height: 0.65,
          validator: (value) {
            CustomMultiDropdownRequiredValidator(value,
                errorText: "Purposes are required ", context: context);
          },
          value: purposeMemory.value,
          enabled: purposeMemory.value.length < 4,
          onSaved: (values) {
            validatePurposes(values);
          },
          onChanged: (values) {
            validatePurposes(values);
          },
          hintText: " ",
          label: "Purposes                      ",
          data: findCatalog("purposes"),
        ),
      );
    });
  }
}

class TransportField extends StatelessWidget {
  const TransportField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFormDropDownFieldWidget(
      height: 0.07,
      label: "Transport Options    ",
      validator: (value) => CustomMultiDropdownRequiredValidator(value,
          errorText: "Day Transport Options are required ", context: context),
      value: getFormValue(globalctx.memory, "tour", "transport", "0"),
      onSaved: (value) {
        transportService.value = value!;
        setFormValue(globalctx.memory, "tour", "transport", value);
      },
      onChanged: (value) {
        transportService.value = value!;
        setFormValue(globalctx.memory, "tour", "transport", value);
      },
      hintText: "",
      data: serviceTypeCatalog.value,
    );
  }
}
