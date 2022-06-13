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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        left: MediaQuery.of(context).size.width * 0.55,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(children: [
            CountryField(readonly: readonly, ctrl: ctrl),
            BudgetField(
                tour: tour,
                readonly: readonly,
                ctrl: ctrl,
                accomodationType: accomodationType),
            PaxField(ctrl: ctrl),
            GalapagosCheckboxField(),
            TransportField(),
            PurposeField(),
            TranslatingField(),
          ]),
        ),
      ),
    );
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
        top: MediaQuery.of(context).size.height * 0.82,
        left: MediaQuery.of(context).size.width * 0.56,
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
    return CustomFormMultiDropDownFieldWidget(
      label: "Translating Services",
      validator: (value) => CustomMultiDropdownRequiredValidator(value,
          errorText: "Translating Service is required ", context: context),
      value: translatingService.value ?? <String>[],
      onSaved: (value) {
        setFormValue(globalctx.memory["destinations"],
            globalDestinationIndex.value, "translating_service", value);
      },
      onChanged: (value) {
        openTranslate.value = false;
        translatingService.value = value;
        setFormValue(globalctx.memory["destinations"],
            globalDestinationIndex.value, "translating_service", value);
      },
      hintText: "",
      data: translatingCatalog.value,
    );
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
          validator: (value) {
            CustomMultiDropdownRequiredValidator(value,
                errorText: "Purposes are required ", context: context);
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
      label: "Transport Options    ",
      validator: (value) => CustomMultiDropdownRequiredValidator(value,
          errorText: "Day Transport Options are required ", context: context),
      value: "0",
      onSaved: (values) {
        transportService.value = values;
      },
      onChanged: (value) {
        transportService.value = value;
      },
      hintText: "",
      data: serviceTypeCatalog.value,
    );
  }
}

class GalapagosCheckboxField extends StatelessWidget {
  const GalapagosCheckboxField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTitleWidget(
            fontWeight: FontWeight.bold,
            label: "  Would you like to take a Galapagos Cruise?",
            color: Colors.black),
        CheckboxIconFormField(
          context: context,
          trueIconColor: Colors.green,
          initialValue:
              getFormValue(globalctx.memory, "tour", "galapagos", false),
          enabled: true,
          iconSize: 32,
          onSaved: (value) {
            setFormValue(globalctx.memory, "tour", "galapagos", value);
          },
          onChanged: (value) {
            setFormValue(globalctx.memory, "tour", "galapagos", value);
          },
        ),
      ],
    );
  }
}
