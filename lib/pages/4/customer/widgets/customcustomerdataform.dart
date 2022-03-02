import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/validators.dart';
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
    var customerTypeCatalog = processCatalog("legal_client_type");

    var client = globalctx.memory["customer"];
    var tour = globalctx.memory["tour"];
    Rx<List<Map<String, dynamic>>> citylist = Rx([]);
    RxString customerType = client["client_type_id"].toString().obs;
    RxString country = getValue(client, "origin_id", def: "148").toString().obs;
    RxString city = client["city_id"].toString().obs;
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
                              value: getValue(client, "legal_client_type_id",
                                  def: "2"),
                              width: 0.2,
                              label: "Customer Type          ",
                              onChanged: (value) {
                                customerType.value = value!;
                                // print(value);
                              },
                              onSaved: (value) {
                                customerType.value = value!;
                                ctrl!.state.customerType = value;
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
                                    value: getValue(client, "tax_id",
                                        def: "2211223322"),
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
                                        def: "Jose"),
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
                                    value: getValue(client, "client_dni",
                                        def: "11223344556677"),
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
                                value: getValue(client, "contact_name",
                                    def: "Jose"),
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
                                value: getValue(client, "contact_name_2",
                                    def: "Cuevas"),
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
                                      errorText: "Birth date is Required");
                                },
                                initialValue: getDateValue(client, "birth_date",
                                    def: DateTime(1981, 02, 20)),
                                onSaved: (value) {
                                  ctrl!.state.birthDate =
                                      "${value.toString().split(" ")[0]}";
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
                        Obx(() {
                          return Row(
                            children: [
                              CustomFormDropDownFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Country is required ",
                                    ctx: context),
                                value:
                                    getValue(client, "origin_id", def: "148"),
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
                              ),
                              // if (country.value != "")
                              CustomFormDropDownFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "City is required ",
                                    ctx: context),
                                value: getValue(client, "city_id", def: "1"),
                                width: 0.1,
                                label: "City          ",
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
                              ),
                            ],
                          );
                        }),
                        CustomFormTextFieldWidget(
                            validator: CustomRequiredValidator(
                                errorText: "Address Line is required ",
                                ctx: context),
                            value: getValue(client, "address", def: "casa"),
                            onSaved: (value) {
                              ctrl!.state.addressLine = value!;
                            },
                            keyboardType: TextInputType.streetAddress,
                            hintText: "Address Line                        ",
                            width: 0.36),
                        CustomFormTextFieldWidget(
                            validator: CustomRequiredValidator(
                                errorText: "Email is required ", ctx: context),
                            value:
                                getValue(client, "email", def: "jose@aol.com"),
                            onSaved: (value) {
                              ctrl!.state.email = value!;
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
                                    def: leadPassenger),
                                onSaved: (value) {
                                  leadPassenger.value = value!;
                                  ctrl!.state.leadPassenger = value;
                                  ctrl!.state.travelCode =
                                      "${getValue(client, "lead_passenger", def: "jose cuevas").toString().replaceAll(" ", "-") + "-" + tour["passengers"] + "-" + dayFormat.format(arrivalDate.value).replaceAll(" ", "-")}";
                                },
                                onChanged: (value) {
                                  travelCode.value =
                                      "${value.toString() + "-" + tour["passengers"] + "-" + dayFormat.format(arrivalDate.value).replaceAll(" ", "-")}";
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Lead Passenger                  ",
                                width: 0.2)
                          ],
                        ),
                        Obx(() {
                          return CustomTitleWidget(
                              width: 0.1,
                              fontWeight: FontWeight.normal,
                              label: "Travel Code: $travelCode");
                        })
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
                      selectedIndex++;
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
