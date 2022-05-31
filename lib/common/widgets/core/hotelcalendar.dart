import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';
import '../../validators.dart';

class HotelCalendarWidget extends StatelessWidget {
  HotelCalendarWidget({
    Key? key,
    this.ctx,
  }) : super(key: key);
  final ctx;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    filterHotels(context);

    return Form(
      key: formKey,
      child: HotelFiltersWidget(ctx: ctx),
    );
  }
}

class HotelFiltersWidget extends StatelessWidget {
  const HotelFiltersWidget({
    Key? key,
    required this.ctx,
  }) : super(key: key);

  final ctx;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        direction: Axis.vertical,
        children: [
          Wrap(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.11,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Hotel Category is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    hotelCategory.value = getCatalogDescription(
                        findMemoryChildCatalog("hotel", "value", "budget_fk"),
                        value);
                    setFormValue(
                        globalctx.memory["destinations"],
                        globalDestinationIndex,
                        "hotelCategory",
                        hotelCategory.value);
                    filterHotels(context);
                  },
                  hintText: "Category     ",
                  data: findMemoryChildCatalog("hotel", "value", "budget_fk")),
              CustomFormMultiDropDownFieldWidget(
                  value: [],
                  onChanged: (value) {},
                  onSaved: (value) {
                    hotelRoomCategory.value = getCatalogDescription(
                        findMemoryChildCatalog("hotel", "value", "roomcategory",
                            condition: (element) {
                          var rule = true;
                          var rt = element["value"]["#roomtypes"] == ""
                              ? 1
                              : element["value"]["#roomtypes"];
                          var mc = element["value"]["maxCapacity"];
                          var pax = globalctx.memory["tour"]["passengers"];

                          rule = rt * mc >= pax;
                          rule = rule &&
                              hotelCategory.value ==
                                  element["value"]["budget_fk"];
                          return rule;
                        }),
                        value);
                    setFormValue(
                        globalctx.memory["destinations"],
                        globalDestinationIndex,
                        "hotelRoomCategory",
                        hotelRoomCategory.value);
                    filterHotels(context);
                  },
                  hintText: "Room Category     ",
                  data: findMemoryChildCatalog("hotel", "value", "roomcategory",
                      condition: (element) {
                    var rule = true;
                    var rt = element["value"]["#roomtypes"] == ""
                        ? 1
                        : element["value"]["#roomtypes"];
                    var mc = element["value"]["maxCapacity"];
                    var pax = globalctx.memory["tour"]["passengers"];

                    rule = rt * mc >= pax;
                    rule = rule &&
                        hotelCategory.value == element["value"]["budget_fk"];
                    return rule;
                  })),
              CustomFormMultiDropDownFieldWidget(
                validator: (value) {
                  CustomMultiDropdownRequiredValidator(value,
                      errorText: "Hotel More filters are required ",
                      context: context);
                },
                value: hotelFilterMemory.value,
                enabled: hotelFilterMemory.value.length < 4,
                onSaved: (values) {
                  if (values == null) return;

                  if (values.length <= 3) {
                    hotelFilterMemory.value = [];
                    var length = values.length;

                    for (var i = 0; i < length; i++) {
                      hotelFilterMemory.value.add(findCatalog("key_activity")
                          .toList()
                          .where((e) => e["code"] == values[i])
                          .toList()[0]["description"]);
                    }
                    setFormValue(
                        globalctx.memory["destinations"],
                        globalDestinationIndex,
                        "hotelFilterMemory",
                        hotelFilterMemory.value);
                  }
                  filterHotels(context);
                },
                onChanged: (values) {},
                hintText: "",
                label: "",
                data: findCatalog("more_hotel_filters"),
              ),
              CustomFormDropDownFieldWidget(
                width: 0.11,
                height: 0.05,
                validator: CustomRequiredValidator(
                    errorText: "Hotel Name is required ", ctx: ctx),
                value: "0",
                onSaved: (value) {},
                onChanged: (value) {
                  hotelName.value = getCatalogDescription(
                      findMemoryChildCatalog("hotel", "value", "hotelname",
                          condition: (element) {
                        var rule = true;
                        var rt = element["value"]["#roomtypes"] == ""
                            ? 1
                            : element["value"]["#roomtypes"];
                        var mc = element["value"]["maxCapacity"];
                        var pax = globalctx.memory["tour"]["passengers"];

                        rule = rt * mc >= pax;
                        rule = rule &&
                            hotelCategory.value ==
                                element["value"]["budget_fk"];
                        rule = rule &&
                            hotelRoomCategory.value
                                .contains(element["value"]["roomcategory"]);
                        return rule;
                      }),
                      value);
                  setFormValue(globalctx.memory["destinations"],
                      globalDestinationIndex, "hotelName", hotelName.value);
                  filterHotels(context);
                },
                hintText: "Hotel Name     ",
                data: findMemoryChildCatalog("hotel", "value", "hotelname",
                    condition: (element) {
                  var rule = true;
                  var rt = element["value"]["#roomtypes"] == ""
                      ? 1
                      : element["value"]["#roomtypes"];
                  var mc = element["value"]["maxCapacity"];
                  var pax = globalctx.memory["tour"]["passengers"];

                  rule = rt * mc >= pax;
                  rule = rule &&
                      hotelCategory.value == element["value"]["budget_fk"];
                  rule = rule &&
                      hotelRoomCategory.value
                          .contains(element["value"]["roomcategory"]);
                  return rule;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HotelKeyPadWidget extends StatelessWidget {
  const HotelKeyPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0,
              left: MediaQuery.of(context).size.width * 0.5),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  hotelName.value = "";
                  hotelCategory.value = "";
                  hotelRoomCategory.value = [];
                  moreFilters.value = false;
                  filterHotels(context);
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              // if (hotelExtrabed.value.isNotEmpty)
              TextButton(
                onPressed: () {
                  showCustomDialog(context, HotelResultWidget(), "Close",
                      backgroundColor: Colors.white);
                },
                child: Text('Process',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              TextButton(
                onPressed: () {
                  moreFilters.value = !moreFilters.value;
                },
                child: Text(
                    !moreFilters.value ? 'More Filters' : 'Less Filters',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
            ],
          ),
        ));
  }
}

class HotelResultWidget extends StatelessWidget {
  const HotelResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        // if (hotelTerraceorPatio.value.isNotEmpty)
        //   if (hotelMaxCapacity.value.isNotEmpty)
        //     if (hotelBalcony.value.isNotEmpty)
        //       if (hotelExtrabed.value.isNotEmpty)
        //         if (hotelExtrabed.value.isNotEmpty)
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.03,
                decoration: BoxDecoration(color: Colors.grey),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Hotel Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "Actions",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0,
                          left: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              if (hotelResults.value.isNotEmpty &&
                                  searcherHeader.value.isNotEmpty)
                                hotelTable.value
                              else
                                Text(
                                  "No Hotels Found",
                                  style: KTextSytle(
                                    context: context,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 204, 164, 61),
                                  ).getStyle(),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ]),
    );
  }
}
