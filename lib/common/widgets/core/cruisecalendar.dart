import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/2/searcher/widgets/index.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../index.dart';

class CruiseCalendarWidget extends StatelessWidget {
  CruiseCalendarWidget({
    Key? key,
    this.ctx,
  }) : super(key: key);
  final ctx;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List columns = ["cruise_name", "modality"];
    var processedData =
        processCruiseData(context, globalctx.memory["cruises"], columns);
    searcherHeader = Rx(processedData[0]);
    if (searchResult!.value.isEmpty) {
      searcherDetail = Rx(processedData[1]);
    }
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Type is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {},
                  label: "Type             ",
                  data: findMemoryCatalog("cruises", "cruise_type")),
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Category is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {},
                  label: "Category  ",
                  data: findMemoryCatalog("cruises", "cruise_category")),
            ],
          ),
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Cruise Modality is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {},
                  onChanged: (value) {},
                  label: "Modality     ",
                  data: findMemoryCatalog("cruises", "modality")),
            ],
          ),
          Row(
            children: [
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Departure Day is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {
                    return;
                  },
                  onChanged: (value) {
                    return;
                  },
                  label: "Departure  ",
                  data: findCatalog("week_day")),
              CustomFormDropDownFieldWidget(
                  width: 0.15,
                  height: 0.05,
                  validator: CustomRequiredValidator(
                      errorText: "Arrival Day is required ", ctx: ctx),
                  value: "0",
                  onSaved: (value) {
                    return;
                  },
                  onChanged: (value) {
                    return;
                  },
                  label: "Arrival         ",
                  data: findCatalog("week_day")),
            ],
          ),
          CustomFormDropDownFieldWidget(
              width: 0.3,
              height: 0.05,
              validator: CustomRequiredValidator(
                  errorText: "Cruise Format is required ", ctx: ctx),
              value: "0",
              onSaved: (value) {},
              onChanged: (value) {},
              label: "Format        ",
              data: findMemoryCatalog("cruises", "cruise_format")),
          Obx(() {
            var t = searcherHeader.value;
            return Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.45,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // SearcherField(data: data, formKey: formKey),
                    DataTable(
                      columns: searcherHeader.value,
                      rows: searcherDetail.value,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
