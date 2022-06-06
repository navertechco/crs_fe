import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:naver_crs/index.dart';

class CustomCustomerDataForm extends StatelessWidget {
  final CustomerController? ctrl;
  final _formKey = GlobalKey<FormState>();

  CustomCustomerDataForm({
    Key? key,
    this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Expanded(
          child: Stack(
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
                              value: client["legal_client_type_id"] ?? "2",
                              width: 0.1,
                              hintText: "Customer Type",
                              onChanged: (value) {
                                customerType.value = value!;
                                log(value);
                              },
                              onSaved: (value) {
                                customerType.value = value!;
                                ctrl!.state.customerType = value;
                                log(value);
                              },
                              data: customerTypeCatalog,
                            ),
                            CustomFormDateFieldWidget(
                                validator: (date) {
                                  CustomDatetimeRequiredValidator(date,
                                      context: context,
                                      errorText: "Birth date is Required");
                                },
                                initialValue: getDateValue(client, "birth_date",
                                    def: DateTime(1981, 02, 12)),
                                onSaved: (value) {
                                  ctrl!.state.birthDate =
                                      value.toString().split(" ")[0];
                                },
                                width: 0.22,
                                hintText: "Birth Day               "),
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
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    hintText: "DNI/PASSPORT         ",
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
                                value: getValue(client, "names", def: "Jose"),
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
                                value: getValue(client, "last_names",
                                    def: "Cuevas"),
                                onSaved: (value) {
                                  ctrl!.state.lastNames = value!;
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Surnames                          ",
                                width: 0.17),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
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
                            label: " Address information"),
                        Obx(() {
                          return Row(
                            children: [
                              CustomFormDropDownFieldWidget(
                                validator: (value) {
                                  CustomRequiredValidator(
                                          errorText: "Country is required ",
                                          ctx: context)
                                      .call(value);
                                  if (city.value.isEmpty) {
                                    SweetAlert.show(context,
                                        curve: ElasticInCurve(),
                                        title: "City Field is required",
                                        style: SweetAlertStyle.error,
                                        onPress: (bool isConfirm) {
                                      Get.close(1);
                                      return false;
                                    });
                                  }
                                },
                                value: country.value,
                                width: country.value == "" ? 0.3 : 0.15,
                                hintText: "Country",
                                onChanged: (value) {
                                  country.value = value!;
                                  cityData(
                                      citylist,
                                      countries[countrylist[int.parse(value)]
                                          ["description"]]);
                                  log("CHANGED: ");
                                },
                                onSaved: (value) {
                                  ctrl!.state.country = value!;
                                  country.value = value;
                                  cityData(
                                      citylist,
                                      countries[countrylist[int.parse(value)]
                                          ["description"]]);
                                  log("SAVED: ");
                                },
                                data: countrydata.value,
                              ),
                              // if (country.value != "")
                              CustomFormDropDownFieldWidget(
                                validator: CustomCatalogRequiredValidator(
                                    errorText: "City is required ",
                                    ctx: context,
                                    catalog: citylist.value),
                                value: city.value,
                                width: 0.1,
                                hintText: "City",
                                onChanged: (value) {
                                  city.value = value!;
                                  log(value);
                                },
                                onSaved: (value) {
                                  city.value = value!;
                                  ctrl!.state.city = value;
                                  log(value);
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
                        const CustomTitleWidget(
                            width: 0.225,
                            fontWeight: FontWeight.bold,
                            label: " Tour information"),
                        Row(
                          children: [
                            CustomFormTextFieldWidget(
                                validator: CustomRequiredValidator(
                                    errorText: "Lead Passenger is required ",
                                    ctx: context),
                                value: leadPassenger.value,
                                onSaved: (value) {
                                  saveTravelCode(ctrl, value);
                                },
                                onChanged: (value) {
                                  saveTravelCode(ctrl, value);
                                },
                                keyboardType: TextInputType.name,
                                hintText: "Lead Passenger",
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
                    top: MediaQuery.of(context).size.height * 0.78,
                    left: MediaQuery.of(context).size.width * 0.7),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (city.value.isEmpty) {
                        SweetAlert.show(context,
                            curve: ElasticInCurve(),
                            title: "City Field is required",
                            style: SweetAlertStyle.error,
                            onPress: (bool isConfirm) {
                          Get.close(1);
                          return false;
                        });
                      } else {
                        ctrl!.saveCustomer();
                      }
                    }
                  },
                  child: const CustomTitleWidget(
                      width: 0.1,
                      fontWeight: FontWeight.normal,
                      label:
                          "                                                             Next >"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
