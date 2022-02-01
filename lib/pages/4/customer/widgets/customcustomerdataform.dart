import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../index.dart';

class CustomCustomerDataForm extends StatelessWidget {
  final CustomerController? ctrl;
  final _formKey = GlobalKey<FormState>();

  CustomCustomerDataForm({
    Key? key,
    this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rx<List<Map<String, dynamic>>> citylist = Rx([]);
    RxString customerType = "".obs;
    RxString country = "".obs;
    RxString city = "".obs;
    List<Map<String, dynamic>> countrylist = [];
    // ignore: prefer_function_declarations_over_variables

    // var countryParam = getParam("COUNTRIES");
    Map<dynamic, dynamic> countries = getContext("countries");
    Rx<List<Map<String, dynamic>>> countrydata = Rx((() {
      // print("Countries: $countries\n\n");
      countrylist = [];
      var index = 0;
      if (countries != null) {
        for (var country in countries.keys) {
          countrylist.add({
            "code": "$index",
            "description": country,
          });
          index++;
        }
      }

      // print("CountryList: $countrylist");
      return countrylist;
    })());

    var customerTypeCatalog = processCatalog("legal_client_type");
    var tourdata = getContext("tour");
    var client = getValue(tourdata, "client");
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45,
                      left: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: SizedBox(
                      child: Column(children: [
                        const CustomTitleWidget(
                            width: 0.225,
                            fontWeight: FontWeight.bold,
                            label: " Basic information"),

                        Row(
                          children: [
                            CustomFormDropDownFieldWidget(
                              validator: CustomRequiredValidator(
                                  errorText: "Legal Client Type is required ",
                                  ctx: context),
                              value: getValue(client, "legal_client:type",
                                  def: "1"),
                              width: 0.2,
                              label: "Customer Type          ",
                              onChanged: (value) {
                                customerType.value = value!;
                                // print(value);
                              },
                              onSaved: (value) {
                                customerType.value = value!;
                                ctrl!.state.legalClientType = value;
                                // print(value);
                              },
                              data: customerTypeCatalog,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() {
                              if (customerType.value == "1") {
                                return CustomFormTextFieldWidget(
                                    validator: CustomRequiredValidator(
                                        errorText: "Tax Id is required ",
                                        ctx: context),
                                    value:
                                        getValue(client, "tax_id", def: "dddd"),
                                    onSaved: (value) {
                                      ctrl!.state.taxId = value!;
                                    },
                                    keyboardType: TextInputType.number,
                                    hintText:
                                        "Tax Id                            ",
                                    width: 0.1);
                              } else {
                                return Text("");
                              }
                            }),
                            Obx(() {
                              if (customerType.value == "1") {
                                return CustomFormTextFieldWidget(
                                    validator: CustomRequiredValidator(
                                        errorText: "Contact Name is required ",
                                        ctx: context),
                                    value: getValue(client, "contact_name",
                                        def: "dddd"),
                                    onSaved: (value) {
                                      ctrl!.state.contactName = value!;
                                    },
                                    keyboardType: TextInputType.name,
                                    hintText: "Legal Contact  Name  ",
                                    width: 0.24);
                              } else {
                                return Text("");
                              }
                            }),
                            Obx(() {
                              if (customerType.value != "1") {
                                return CustomFormTextFieldWidget(
                                    validator: CustomRequiredValidator(
                                        errorText: "DNI/Passport is required ",
                                        ctx: context),
                                    value: getValue(client, "dni", def: "dddd"),
                                    onSaved: (value) {
                                      ctrl!.state.dni = value!;
                                    },
                                    keyboardType: TextInputType.number,
                                    label: "DNI/PASSPORT         ",
                                    width: 0.24);
                              } else {
                                return Text("");
                              }
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            CustomFormTextFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Names is required ",
                                    ctx: context),
                                value: getValue(client, "names", def: "dddd"),
                                onSaved: (value) {
                                  ctrl!.state.names = value!;
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Names                          ",
                                width: 0.17),
                            CustomFormTextFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Last Names is required ",
                                    ctx: context),
                                value:
                                    getValue(client, "last_names", def: "dddd"),
                                onSaved: (value) {
                                  ctrl!.state.lastNames = value!;
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Surnames                          ",
                                width: 0.17),
                          ],
                        ),

                        Row(
                          children: [
                            CustomFormDateFieldWidget(
                                validator: (date) {
                                  CustomDatetimeRequiredValidator(date,
                                      context: context,
                                      errorText: "Birth day is Required");
                                },
                                initialValue: getValue(client, "birthday",
                                    def: DateTime(1981, 02, 20)),
                                onSaved: (value) {
                                  ctrl!.state.birthDate = value!;
                                },
                                width: 0.35,
                                hintText: "Birth Day               "),
                          ],
                        ),
                        // CustomKeypadWidget(),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: SizedBox(
                      child: Column(children: [
                        const CustomTitleWidget(
                            width: 0.225,
                            fontWeight: FontWeight.bold,
                            label: "  "),
                        Row(
                          children: [
                            Obx(() {
                              return CustomFormDropDownFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Country is required ",
                                    ctx: context),
                                value: getValue(client, "country", def: "1"),
                                width: country.value == "" ? 0.2 : 0.1,
                                label: "Country          ",
                                onChanged: (value) {
                                  country.value = value!;
                                  cityData(
                                      citylist,
                                      countries[countrylist[int.parse(value)]
                                          ["description"]]);
                                  // print("CHANGED: ");
                                },
                                onSaved: (value) {
                                  ctrl!.state.country = value!;
                                  country.value = value;
                                  cityData(
                                      citylist,
                                      countries[countrylist[int.parse(value)]
                                          ["description"]]);
                                  // print("SAVED: ");
                                },
                                data: countrydata.value,
                              );
                            }),
                            Obx(() {
                              if (country.value != "") {
                                return CustomFormDropDownFieldWidget(
                                  validator: CustomRequiredValidator(
                                      errorText: "City is required ",
                                      ctx: context),
                                  value: getValue(client, "city", def: "1"),
                                  width: 0.1,
                                  hintText: "City          ",
                                  onChanged: (value) {
                                    city.value = value!;
                                    // print(value);
                                  },
                                  onSaved: (value) {
                                    city.value = value!;
                                    ctrl!.state.city = value;
                                    // print(value);
                                  },
                                  data: citylist.value,
                                );
                              } else {
                                return Text("");
                              }
                            }),
                          ],
                        ),
                        CustomFormTextFieldWidget(
                            validator: CustomRequiredValidator(
                                errorText: "Address Line is required ",
                                ctx: context),
                            value:
                                getValue(client, "address_line", def: "dddd"),
                            onSaved: (value) {
                              ctrl!.state.addressLine = value!;
                            },
                            keyboardType: TextInputType.streetAddress,
                            hintText: "Address Line                        ",
                            width: 0.36),
                        CustomFormTextFieldWidget(
                            validator: CustomRequiredValidator(
                                errorText: "Email is required ", ctx: context),
                            value: getValue(client, "email", def: "dddd"),
                            onSaved: (value) {
                              ctrl!.state.taxId = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            hintText: "e-Mail                          ",
                            width: 0.36),
                        Row(
                          children: [
                            CustomFormTextFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Lead Passenger is required ",
                                    ctx: context),
                                value: getValue(client, "lead_passenger",
                                    def: "dddd"),
                                onSaved: (value) {
                                  ctrl!.state.leadPassenger = value!;
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Lead Passenger                  ",
                                width: 0.2),
                            CustomFormTextFieldWidget(
                                value: getValue(client, "travel_code",
                                    def: "dddd"),
                                onSaved: (value) {
                                  ctrl!.state.travelCode = value!;
                                },
                                keyboardType: TextInputType.number,
                                hintText: "Travel Code                ",
                                width: 0.15),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.7),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ctrl!.saveCustomer();
                    }
                  },
                  child: const CustomTitleWidget(
                      width: 0.1,
                      fontWeight: FontWeight.normal,
                      label:
                          " \n                                                             Next >"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
