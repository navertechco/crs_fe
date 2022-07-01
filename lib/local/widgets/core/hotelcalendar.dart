// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
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
                        getMemoryCatalogChild("hotel", "value", "budget_fk"),
                        value);
                    setFormValue(
                        globalctx.memory["destinations"],
                        globalDestinationIndex,
                        "hotelCategory",
                        hotelCategory.value);
                    filterHotels(context);
                  },
                  hintText: "Budget     ",
                  data: getMemoryCatalogChild("hotel", "value", "budget_fk")),
              CustomFormMultiDropDownFieldWidget(
                  value: [],
                  onChanged: (value) {},
                  onSaved: (value) {
                    hotelRoomCategory.value = getCatalogDescription(
                        getMemoryCatalogChild("hotel", "value", "roomcategory",
                            condition: (element) {
                          var rule = true;
                          var rt = element["value"]["#roomtypes"] == ''
                              ? 1
                              : element["value"]["#roomtypes"];
                          var mc = element["value"]["maxCapacity"];
                          var pax = globalctx.memory["tour"]["passengers"];

                          rule = rt * mc >= pax;
                          rule = rule &&
                              hotelCategory.value ==
                                  element["value"]["budget_fk"];
                          var filter = hotelResults.value
                              .map((e) => e["description"])
                              .toList();
                          rule = filter.contains(element["description"]);
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
                  data: getMemoryCatalogChild("hotel", "value", "roomcategory",
                      condition: (element) {
                    var rule = true;
                    var rt = element["value"]["#roomtypes"] == ''
                        ? 1
                        : element["value"]["#roomtypes"];
                    var mc = element["value"]["maxCapacity"];
                    var pax = globalctx.memory["tour"]["passengers"];

                    rule = rt * mc >= pax;
                    rule = rule &&
                        hotelCategory.value == element["value"]["budget_fk"];
                    var filter = hotelResults.value
                        .map((e) => e["description"])
                        .toList();
                    rule = filter.contains(element["description"]);
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
                onChanged: (values) {
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
                hintText: "More Filters     ",
                label: '',
                data: findCatalog("more_hotel_filters").where((e) {
                  var rule = true;
                  var filter = hotelResults.value
                      .map((f) => f["value"][e["value"]["key"]] == "Yes")
                      .toSet()
                      .toList()[0];
                  rule = filter;
                  return rule;
                }).toList(),
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
              left: MediaQuery.of(context).size.width * 0.4),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  hotelName.value = '';
                  hotelCategory.value = '';
                  hotelRoomCategory.value = [];
                  moreFilters.value = false;
                  filterHotels(context);
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              // if (hotelExtrabed.isNotEmpty)
              TextButton(
                onPressed: () {
                  showCustomDialog(context, HotelResultWidget(), "Close",
                      backgroundColor: Colors.white);
                },
                child: Text('Process',
                    style: KTextSytle(
                            context: context,
                            fontSize: isMobile * 10,
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
                            fontSize: isMobile * 10,
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
        // if (hotelTerraceorPatio.isNotEmpty)
        //   if (hotelMaxCapacity.isNotEmpty)
        //     if (hotelBalcony.isNotEmpty)
        //       if (hotelExtrabed.isNotEmpty)
        //         if (hotelExtrabed.isNotEmpty)
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
                    SizedBox(
                      child: Text(
                        "Hotel Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
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
            SizedBox(
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
                          child: Obx(() => Column(
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
                                        color:
                                            Color.fromARGB(255, 204, 164, 61),
                                      ).getStyle(),
                                    )
                                ],
                              )),
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
