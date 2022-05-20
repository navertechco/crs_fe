import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';

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
                      errorText: "Hotel TerraceorPatio is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {
                    hotelCategory.value = getCatalogDescription(
                        findMemoryChildCatalog(
                            "hotels", "value", "TerraceorPatio"),
                        value);
                    filterHotels(context);
                  },
                  hintText: "TerraceorPatio             ",
                  data: findMemoryChildCatalog(
                      "hotels", "value", "TerraceorPatio")),
              if (hotelCategory.value.isNotEmpty)
                CustomFormDropDownFieldWidget(
                    width: 0.11,
                    height: 0.05,
                    validator: CustomRequiredValidator(
                        errorText: "Hotel maxCapacity is required ", ctx: ctx),
                    value: "0",
                    onSaved: (value) {},
                    onChanged: (value) {
                      hotelRoomCategory.value = getCatalogDescription(
                          findMemoryChildCatalog(
                              "hotels", "value", "maxCapacity"),
                          value);
                      filterHotels(context);
                    },
                    hintText: "maxCapacity     ",
                    data: findMemoryChildCatalog(
                        "hotels", "value", "maxCapacity")),
              if (hotelCategory.value.isNotEmpty)
                if (hotelRoomCategory.value.isNotEmpty)
                  CustomFormDropDownFieldWidget(
                      width: 0.11,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Hotel Balcony is required ", ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        hotelBalcony.value = getCatalogDescription(
                            findMemoryChildCatalog(
                                "hotels", "value", "Balcony"),
                            value);
                        filterHotels(context);
                      },
                      hintText: "Balcony     ",
                      data:
                          findMemoryChildCatalog("hotels", "value", "Balcony")),
              if (hotelCategory.value.isNotEmpty)
                if (hotelRoomCategory.value.isNotEmpty)
                  if (hotelBalcony.value.isNotEmpty)
                    CustomFormDropDownFieldWidget(
                        width: 0.11,
                        height: 0.05,
                        validator: CustomRequiredValidator(
                            errorText: "Hotel extrabed is required ", ctx: ctx),
                        value: "0",
                        onSaved: (value) {},
                        onChanged: (value) {
                          hotelOutsideWindow.value = getCatalogDescription(
                              findMemoryChildCatalog(
                                  "hotels", "value", "extrabed"),
                              value);
                          filterHotels(context);
                        },
                        hintText: "extrabed             ",
                        data: findMemoryChildCatalog(
                            "hotels", "value", "extrabed")),
            ],
          ),
          if (moreFilters.value)
            Wrap(
              children: [
                CustomFormDropDownFieldWidget(
                    width: 0.11,
                    height: 0.05,
                    validator: CustomRequiredValidator(
                        errorText: "Hotel petFriendly is required ", ctx: ctx),
                    value: "0",
                    onSaved: (value) {},
                    onChanged: (value) {
                      hotelCategory.value = getCatalogDescription(
                          findMemoryChildCatalog(
                              "hotels", "value", "petFriendly"),
                          value);
                      filterHotels(context);
                    },
                    hintText: "petFriendly             ",
                    data: findMemoryChildCatalog(
                        "hotels", "value", "petFriendly")),
                if (hotelCategory.value.isNotEmpty)
                  CustomFormDropDownFieldWidget(
                      width: 0.11,
                      height: 0.05,
                      validator: CustomRequiredValidator(
                          errorText: "Hotel roomcategory is required ",
                          ctx: ctx),
                      value: "0",
                      onSaved: (value) {},
                      onChanged: (value) {
                        hotelRoomCategory.value = getCatalogDescription(
                            findMemoryChildCatalog(
                                "hotels", "value", "roomcategory"),
                            value);
                        filterHotels(context);
                      },
                      hintText: "roomcategory     ",
                      data: findMemoryChildCatalog(
                          "hotels", "value", "roomcategory")),
                if (hotelCategory.value.isNotEmpty)
                  if (hotelRoomCategory.value.isNotEmpty)
                    CustomFormDropDownFieldWidget(
                        width: 0.11,
                        height: 0.05,
                        validator: CustomRequiredValidator(
                            errorText: "Hotel TuborJacuzzi is required ",
                            ctx: ctx),
                        value: "0",
                        onSaved: (value) {},
                        onChanged: (value) {
                          hotelTuborJacuzzi.value = getCatalogDescription(
                              findMemoryChildCatalog(
                                  "hotels", "value", "TuborJacuzzi"),
                              value);
                          filterHotels(context);
                        },
                        hintText: "TuborJacuzzi     ",
                        data: findMemoryChildCatalog(
                            "hotels", "value", "TuborJacuzzi")),
                if (hotelCategory.value.isNotEmpty)
                  if (hotelRoomCategory.value.isNotEmpty)
                    if (hotelBalcony.value.isNotEmpty)
                      CustomFormDropDownFieldWidget(
                          width: 0.11,
                          height: 0.05,
                          validator: CustomRequiredValidator(
                              errorText: "Hotel childFriendly is required ",
                              ctx: ctx),
                          value: "0",
                          onSaved: (value) {},
                          onChanged: (value) {
                            hotelOutsideWindow.value = getCatalogDescription(
                                findMemoryChildCatalog(
                                    "hotels", "value", "childFriendly"),
                                value);
                            filterHotels(context);
                          },
                          hintText: "childFriendly             ",
                          data: findMemoryChildCatalog(
                              "hotels", "value", "childFriendly")),
                if (hotelCategory.value.isNotEmpty)
                  if (hotelRoomCategory.value.isNotEmpty)
                    if (hotelBalcony.value.isNotEmpty)
                      CustomFormDropDownFieldWidget(
                          width: 0.11,
                          height: 0.05,
                          validator: CustomRequiredValidator(
                              errorText: "Hotel infantFriendly is required ",
                              ctx: ctx),
                          value: "0",
                          onSaved: (value) {},
                          onChanged: (value) {
                            hotelOutsideWindow.value = getCatalogDescription(
                                findMemoryChildCatalog(
                                    "hotels", "value", "infantFriendly"),
                                value);
                            filterHotels(context);
                          },
                          hintText: "infantFriendly             ",
                          data: findMemoryChildCatalog(
                              "hotels", "value", "infantFriendly")),
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
                  hotelCategory.value = "";
                  hotelRoomCategory.value = "";
                  hotelBalcony.value = "";
                  hotelOutsideWindow.value = "";
                  hotelStarts.value = "";
                  hotelEnds.value = "";
                  moreFilters.value = false;
                },
                child: Text('Reset',
                    style: KTextSytle(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                        .getStyle()),
              ),
              if (hotelStarts.value.isNotEmpty)
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
              if (hotelStarts.value.isNotEmpty)
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
        if (hotelCategory.value.isNotEmpty)
          if (hotelRoomCategory.value.isNotEmpty)
            if (hotelBalcony.value.isNotEmpty)
              if (hotelOutsideWindow.value.isNotEmpty)
                if (hotelStarts.value.isNotEmpty)
                  if (hotelEnds.value.isNotEmpty)
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "Actions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.0,
                                      left: MediaQuery.of(context).size.width *
                                          0.03,
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
                                                color: Color.fromARGB(
                                                    255, 204, 164, 61),
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
