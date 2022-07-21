import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalertv2/sweetalertv2.dart';

class CustomCustomerDataForm extends StatelessWidget {
  final CustomerController? ctrl;
  final _formKey = GlobalKey<FormState>();

  CustomCustomerDataForm({
    Key? key,
    this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Stack(
            children: [
              BasicInformation(ctrl: ctrl),
              AddressInformation(ctrl: ctrl),
              TourInformation(ctrl: ctrl),
            ],
          ),
        ),
        CustomerKeyPad(formKey: _formKey, ctrl: ctrl),
      ],
    );
  }
}

class AddressInformation extends StatelessWidget {
  const AddressInformation({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final CustomerController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          top:
              MediaQuery.of(context).size.height * (visible.value ? 0.2 : 0.39),
          left: MediaQuery.of(context).size.width * 0.52,
        ),
        child: SizedBox(
          child: Wrap(children: [
            CustomTitleWidget(
                fontSize: 10,
                width: 0.22,
                fontWeight: FontWeight.bold,
                label: "Address information"),
            Row(
              children: [
                CustomFormDropDownFieldWidget(
                  fontSize: 10,
                  width: 0.13,
                  height: 0.05,
                  validator: (value) {
                    CustomRequiredValidator(
                        errorText: "Country is required ", ctx: context);
                  },
                  value: getFormValue(
                      globalctx.memory, "customer", "country", "1"),
                  hintText: "Country",
                  onChanged: (value) {
                    ctrl!.state.country = value!;
                    getStates(ctrl);
                    setFormValue(
                        globalctx.memory, "customer", "country", value);
                  },
                  onSaved: (value) {
                    ctrl!.state.country = value!;
                    getStates(ctrl);
                    setFormValue(
                        globalctx.memory, "customer", "country", value);
                  },
                  data: getCountries(),
                ),
                if (customerStates.value.isNotEmpty)
                  CustomFormDropDownFieldWidget(
                    fontSize: 10,
                    width: 0.13,
                    height: 0.05,
                    validator: (value) {
                      CustomRequiredValidator(
                          errorText: "State is required ", ctx: context);
                    },
                    value: getFormValue(
                        globalctx.memory, "customer", "state", "0"),
                    hintText: "State",
                    onChanged: (value) {
                      ctrl!.state.state = value!;
                      getCities(ctrl);
                      setFormValue(
                          globalctx.memory, "customer", "state", value);
                    },
                    onSaved: (value) {
                      ctrl!.state.state = value!;
                      getCities(ctrl);
                      setFormValue(
                          globalctx.memory, "customer", "state", value);
                    },
                    data: customerStates.value,
                  ),
                if (customerCities.value.isNotEmpty)
                  CustomFormDropDownFieldWidget(
                    fontSize: 10,
                    width: 0.13,
                    height: 0.05,
                    validator: (value) {
                      CustomRequiredValidator(
                          errorText: "City is required ", ctx: context);
                    },
                    value:
                        getFormValue(globalctx.memory, "customer", "city", "0"),
                    hintText: "City",
                    onChanged: (value) {
                      ctrl!.state.city = value!;
                      setFormValue(globalctx.memory, "customer", "city", value);
                    },
                    onSaved: (value) {
                      ctrl!.state.city = value!;
                      setFormValue(globalctx.memory, "customer", "city", value);
                    },
                    data: customerCities.value,
                  ),
              ],
            ),
            CustomFormTextFieldWidget(
              fontSize: 10,
              validator: CustomRequiredValidator(
                  errorText: "Address Line is required ", ctx: context),
              value: getFormValue(globalctx.memory, "customer", "address", ""),
              onSaved: (value) {
                ctrl!.state.addressLine = value!;
                setFormValue(globalctx.memory, "customer", "address", value);
              },
              onChanged: (value) {
                visible.value = keyboardIsVisible(context);
                ctrl!.state.addressLine = value!;
                setFormValue(globalctx.memory, "customer", "address", value);
              },
              onFieldSubmitted: (value) {
                visible.value = !keyboardIsVisible(context);
                ctrl!.state.addressLine = value!;
                setFormValue(globalctx.memory, "customer", "address", value);
              },
              keyboardType: TextInputType.streetAddress,
              hintText: "Address Line                        ",
              width: 0.4,
              height: 0.05,
            ),
            CustomFormTextFieldWidget(
              fontSize: 10,
              validator: CustomRequiredValidator(
                  errorText: "Email is required ", ctx: context),
              value: getFormValue(globalctx.memory, "customer", "email", ""),
              onSaved: (value) {
                ctrl!.state.email = value!;
                setFormValue(globalctx.memory, "customer", "email", value);
              },
              onChanged: (value) {
                visible.value = keyboardIsVisible(context);
                ctrl!.state.email = value!;
                setFormValue(globalctx.memory, "customer", "email", value);
              },
              onFieldSubmitted: (value) {
                visible.value = !keyboardIsVisible(context);
                ctrl!.state.email = value!;
                setFormValue(globalctx.memory, "customer", "email", value);
              },
              keyboardType: TextInputType.emailAddress,
              hintText: "e-Mail                          ",
              width: 0.4,
              height: 0.05,
            ),
          ]),
        ),
      );
    });
  }
}

class CustomerKeyPad extends StatelessWidget {
  const CustomerKeyPad({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.ctrl,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final CustomerController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.75,
          left: MediaQuery.of(context).size.width * 0.7),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (city.value.isEmpty) {
              SweetAlertV2.show(context,
                  curve: ElasticInCurve(),
                  title: "City Field is required",
                  style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
                Get.close(1);
                return false;
              });
            } else {
              saveCustomer(ctrl!.state);
            }
          }
        },
        child: const CustomTitleWidget(
            fontSize: 10,
            width: 0.1,
            fontWeight: FontWeight.normal,
            label:
                "                                                             Next >"),
      ),
    );
  }
}

class BasicInformation extends StatelessWidget {
  const BasicInformation({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final CustomerController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height *
              isMobile *
              (!visible.value ? 0.4 : 0.2),
          left: MediaQuery.of(context).size.width * isMobile * 0.08,
        ),
        child: SizedBox(
          child: Wrap(children: [
            const CustomTitleWidget(
                fontSize: 10,
                width: 0.22,
                fontWeight: FontWeight.bold,
                label: " Basic information"),

            Row(
              children: [
                CustomFormDropDownFieldWidget(
                  fontSize: 10,
                  validator: CustomRequiredValidator(
                      errorText: "Legal Client Type is required ",
                      ctx: context),
                  value: getFormValue(globalctx.memory, "customer",
                      "legal_client_type_id", "2"),
                  width: 0.2,
                  height: 0.05,
                  hintText: "Customer Type",
                  onChanged: (value) {
                    customerType.value = value!;
                    setFormValue(globalctx.memory, "customer",
                        "legal_client_type_id", value);
                  },
                  onSaved: (value) {
                    customerType.value = value!;
                    ctrl!.state.customerType = value;
                    setFormValue(globalctx.memory, "customer",
                        "legal_client_type_id", value);
                  },
                  data: customerTypeCatalog,
                ),
                CustomFormDateFieldWidget(
                    fontSize: 10,
                    validator: (date) {
                      CustomDatetimeRequiredValidator(date,
                          context: context,
                          errorText: "Birth date is Required");
                    },
                    initialValue: getFormValue(globalctx.memory, "customer",
                        "birth_date", DateTime(1950, 01, 01)),
                    onSaved: (value) {
                      setFormValue(
                          globalctx.memory, "customer", "birth_date", value);
                    },
                    onChanged: (value) {
                      setFormValue(
                          globalctx.memory, "customer", "birth_date", value);
                    },
                    width: 0.2,
                    height: 0.05,
                    hintText: "Birth Day               "),
              ],
            ),
            Row(
              children: [
                Obx(() {
                  if (customerType.value == "1") {
                    return CustomFormTextFieldWidget(
                      fontSize: 10,
                      width: 0.2,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Tax Id is required ", ctx: context),
                      value: getFormValue(
                          globalctx.memory, "customer", "client_dni", ""),
                      onSaved: (value) {
                        ctrl!.state.taxId = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      onChanged: (value) {
                        visible.value = keyboardIsVisible(context);
                        ctrl!.state.taxId = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      onFieldSubmitted: (value) {
                        visible.value = !keyboardIsVisible(context);
                        ctrl!.state.taxId = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      keyboardType: TextInputType.number,
                      hintText: "Tax Id                            ",
                    );
                  } else {
                    return Text('');
                  }
                }),
                Obx(() {
                  if (customerType.value == "1") {
                    return CustomFormTextFieldWidget(
                      fontSize: 10,
                      width: 0.2,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Contact Name is required ", ctx: context),
                      value: getFormValue(
                          globalctx.memory, "customer", "contact_name", ""),
                      onSaved: (value) {
                        ctrl!.state.contactName = value!;
                        setFormValue(globalctx.memory, "customer",
                            "contact_name", value);
                      },
                      onChanged: (value) {
                        visible.value = keyboardIsVisible(context);
                        ctrl!.state.contactName = value!;
                        setFormValue(globalctx.memory, "customer",
                            "contact_name", value);
                      },
                      onFieldSubmitted: (value) {
                        visible.value = !keyboardIsVisible(context);
                        ctrl!.state.contactName = value!;
                        setFormValue(globalctx.memory, "customer",
                            "contact_name", value);
                      },
                      keyboardType: TextInputType.name,
                      hintText: "Legal Contact  Name  ",
                    );
                  } else {
                    return Text('');
                  }
                }),
                Obx(() {
                  if (customerType.value != "1") {
                    return CustomFormTextFieldWidget(
                      fontSize: 10,
                      width: 0.2,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "DNI/Passport is required ", ctx: context),
                      value: getFormValue(
                          globalctx.memory, "customer", "client_dni", ""),
                      onSaved: (value) {
                        ctrl!.state.dni = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      onChanged: (value) {
                        visible.value = keyboardIsVisible(context);
                        ctrl!.state.dni = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      onFieldSubmitted: (value) {
                        visible.value = !keyboardIsVisible(context);
                        ctrl!.state.dni = value!;
                        setFormValue(
                            globalctx.memory, "customer", "client_dni", value);
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      hintText: "DNI/PASSPORT         ",
                    );
                  } else {
                    return Text('');
                  }
                }),
              ],
            ),
            Row(
              children: [
                CustomFormTextFieldWidget(
                  fontSize: 10,
                  width: 0.2,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Names is required ", ctx: context),
                  value:
                      getFormValue(globalctx.memory, "customer", "names", ""),
                  onSaved: (value) {
                    ctrl!.state.names = value!;
                    setFormValue(globalctx.memory, "customer", "names", value);
                  },
                  onChanged: (value) {
                    visible.value = keyboardIsVisible(context);
                    ctrl!.state.names = value!;
                    setFormValue(globalctx.memory, "customer", "names", value);
                  },
                  onFieldSubmitted: (value) {
                    visible.value = !keyboardIsVisible(context);
                    ctrl!.state.names = value!;
                    setFormValue(globalctx.memory, "customer", "names", value);
                  },
                  keyboardType: TextInputType.name,
                  hintText: "Names                          ",
                ),
                CustomFormTextFieldWidget(
                  fontSize: 10,
                  width: 0.2,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Last Names is required ", ctx: context),
                  value: getFormValue(
                      globalctx.memory, "customer", "last_names", ""),
                  onSaved: (value) {
                    ctrl!.state.lastNames = value!;
                    setFormValue(
                        globalctx.memory, "customer", "last_names", value);
                  },
                  onChanged: (value) {
                    visible.value = keyboardIsVisible(context);
                    ctrl!.state.lastNames = value!;
                    setFormValue(
                        globalctx.memory, "customer", "last_names", value);
                  },
                  onFieldSubmitted: (value) {
                    visible.value = !keyboardIsVisible(context);
                    ctrl!.state.lastNames = value!;
                    setFormValue(
                        globalctx.memory, "customer", "last_names", value);
                  },
                  keyboardType: TextInputType.name,
                  hintText: "Surnames                          ",
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            // CustomKeypadWidget(),
          ]),
        ),
      );
    });
  }
}

class TourInformation extends StatelessWidget {
  const TourInformation({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  final CustomerController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height *
              isMobile *
              (!visible.value ? 0.65 : 0.43),
          left: MediaQuery.of(context).size.width * isMobile * 0.085,
        ),
        child: Wrap(
          children: [
            Wrap(
              children: [
                const CustomTitleWidget(
                    fontSize: 10,
                    width: 0.22,
                    fontWeight: FontWeight.bold,
                    label: " Tour information"),
              ],
            ),
            Row(
              children: [
                CustomFormTextFieldWidget(
                  fontSize: 10,
                  width: 0.2,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Lead Passenger is required ", ctx: context),
                  value: travelCode.value,
                  onChanged: (value) {
                    visible.value = keyboardIsVisible(context);
                    saveCustomerTravelCode(value);
                  },
                  onSaved: (value) {
                    saveCustomerTravelCode(value);
                  },
                  onFieldSubmitted: (value) {
                    visible.value = !keyboardIsVisible(context);
                    saveCustomerTravelCode(value);
                  },
                  keyboardType: TextInputType.name,
                  hintText: "Lead Passenger",
                ),
                Obx(() {
                  return CustomTitleWidget(
                      fontSize: 10,
                      width: 0.1,
                      fontWeight: FontWeight.bold,
                      label:
                          "Travel Code: ${getFormValue(globalctx.memory, "tour", "travel_code", "$travelCode")}");
                })
              ],
            ),
          ],
        ),
      );
    });
  }
}
