import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
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
              TourInformation(ctrl: ctrl),
              AddressInformation(ctrl: ctrl),
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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.39,
        left: MediaQuery.of(context).size.width * 0.52,
      ),
      child: SizedBox(
        child: Wrap(children: [
          const CustomTitleWidget(
              fontSize: 10,
              width: 0.22,
              fontWeight: FontWeight.bold,
              label: " Address information"),
          Obx(() {
            return Row(
              children: [
                CustomFormDropDownFieldWidget(
                  fontSize: 10,
                  width: 0.2,
                  height: 0.05,
                  validator: (value) {
                    CustomRequiredValidator(
                            errorText: "Country is required ", ctx: context)
                        .call(value);
                    if (city.value.isEmpty) {
                      SweetAlertV2.show(context,
                          curve: ElasticInCurve(),
                          title: "City Field is required",
                          style: SweetAlertV2Style.error,
                          onPress: (bool isConfirm) {
                        Get.close(1);
                        return false;
                      });
                    }
                  },
                  value: country.value,
                  hintText: "Country",
                  onChanged: (value) {
                    country.value = value!;
                    procCityData(
                        citylist,
                        countries[countrylist[int.parse(value)]
                            ["description"]]);
                    log("CHANGED: ");
                  },
                  onSaved: (value) {
                    ctrl!.state.country = value!;
                    country.value = value;
                    procCityData(
                        citylist,
                        countries[countrylist[int.parse(value)]
                            ["description"]]);
                    log("SAVED: ");
                  },
                  data: countrydata.value,
                ),
                // if (country.value != '')
                CustomFormDropDownFieldWidget(
                  fontSize: 10,
                  validator: CustomCatalogRequiredValidator(
                      errorText: "City is required ",
                      ctx: context,
                      catalog: citylist.value),
                  value: city.value,
                  width: 0.2,
                  height: 0.05,
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
            fontSize: 10,
            validator: CustomRequiredValidator(
                errorText: "Address Line is required ", ctx: context),
            value: getValue(client, "address", def: "casa"),
            onSaved: (value) {
              ctrl!.state.addressLine = value!;
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
            value: getValue(client, "email", def: "jose@aol.com"),
            onSaved: (value) {
              ctrl!.state.email = value!;
            },
            keyboardType: TextInputType.emailAddress,
            hintText: "e-Mail                          ",
            width: 0.4,
            height: 0.05,
          ),
        ]),
      ),
    );
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
      child: GestureDetector(
        onTap: () {
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
              ctrl!.saveCustomer();
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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * isMobile * 0.4,
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
                    errorText: "Legal Client Type is required ", ctx: context),
                value: client["legal_client_type_id"] ?? "2",
                width: 0.2,
                height: 0.05,
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
                  fontSize: 10,
                  validator: (date) {
                    CustomDatetimeRequiredValidator(date,
                        context: context, errorText: "Birth date is Required");
                  },
                  initialValue: getDateValue(client, "birth_date",
                      def: DateTime(1981, 02, 12)),
                  onSaved: (value) {
                    ctrl!.state.birthDate = value.toString().split(" ")[0];
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
                    value: getValue(client, "tax_id", def: "2211223322"),
                    onSaved: (value) {
                      ctrl!.state.taxId = value!;
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
                    value: getValue(client, "contact_name", def: "Jose"),
                    onSaved: (value) {
                      ctrl!.state.contactName = value!;
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
                    value:
                        getValue(client, "client_dni", def: "11223344556677"),
                    onSaved: (value) {
                      ctrl!.state.dni = value!;
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
                value: getValue(client, "names", def: "Jose"),
                onSaved: (value) {
                  ctrl!.state.names = value!;
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
                value: getValue(client, "last_names", def: "Cuevas"),
                onSaved: (value) {
                  ctrl!.state.lastNames = value!;
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
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * isMobile * 0.7,
        left: MediaQuery.of(context).size.width * isMobile * 0.085,
      ),
      child: Row(
        children: [
          const CustomTitleWidget(
              fontSize: 10,
              width: 0.22,
              fontWeight: FontWeight.bold,
              label: " Tour information"),
          CustomFormTextFieldWidget(
            fontSize: 10,
            width: 0.2,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Lead Passenger is required ", ctx: context),
            value: leadPassenger.value,
            onSaved: (value) {
              saveCustomerTravelCode(ctrl, value);
            },
            onChanged: (value) {
              saveCustomerTravelCode(ctrl, value);
            },
            keyboardType: TextInputType.name,
            hintText: "Lead Passenger",
          ),
          Obx(() {
            return CustomTitleWidget(
                fontSize: 10,
                width: 0.1,
                fontWeight: FontWeight.bold,
                label: "Travel Code: $travelCode");
          })
        ],
      ),
    );
  }
}
