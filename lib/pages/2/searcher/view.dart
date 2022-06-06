import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';
import 'widgets/index.dart';

class SearcherPage extends GetView<SearcherController> {
  const SearcherPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView(context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: BodyLayoutWidget(
          background: "assets/custom/img/layout.png",
          child: Stack(
            children: [
              QuoteHistoryTitle(),
              QuoteHistoryFilter(),
              // QuoteHistoryButton(),
              QuoteHistoryTable(controller: controller),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    try {
      return _buildView(context);
    } catch (e) {
      return Text("");
    }
  }
}

class QuoteHistoryTable extends StatelessWidget {
  const QuoteHistoryTable({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SearcherController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.0,
          left: MediaQuery.of(context).size.width * 0.0,
        ),
        child: SearcherWidget(
          ctrl: controller,
        ));
  }
}

class QuoteHistoryButton extends StatelessWidget {
  const QuoteHistoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.83,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Obx(() => TextButton(
            onPressed: () {
              quoteDisplay.value = !quoteDisplay.value;
            },
            child: Text(!quoteDisplay.value ? 'Display' : 'Hide',
                style: KTextSytle(
                  context: context,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ).getStyle()),
          )),
    );
  }
}

class QuoteHistoryFilter extends StatelessWidget {
  const QuoteHistoryFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.38,
        left: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Wrap(
        children: [
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Date is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteDate.value = getCatalogDescription(
                  getMemoryCatalogChild(
                    "tours",
                    "",
                    "date",
                  ),
                  value);
              filterQuoteHistory(context);
            },
            hintText: "Quote Date",
            data: getMemoryCatalogChild(
              "tours",
              "",
              "date",
            ),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Name is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteName.value = getCatalogDescription(
                  getMemoryCatalogChild("tours", "", "name",
                      filter: {"key": "date", "value": quoteDate.value}),
                  value);
              filterQuoteHistory(context);
            },
            hintText: "Quote Name",
            data: getMemoryCatalogChild("tours", "", "name",
                filter: {"key": "date", "value": quoteDate.value}),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Id is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteId.value = getCatalogDescription(
                  getMemoryCatalogChild("tours", "", "quote",
                      filter: {"key": "date", "value": quoteDate.value}),
                  value);
              filterQuoteHistory(context);
            },
            hintText: "Quote Id",
            data: getMemoryCatalogChild("tours", "", "quote",
                filter: {"key": "date", "value": quoteDate.value}),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote State is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteState.value = getCatalogDescription(
                  getMemoryCatalogChild("tours", "", "state",
                      filter: {"key": "date", "value": quoteDate.value}),
                  value);
              filterQuoteHistory(context);
            },
            hintText: "Quote State",
            data: getMemoryCatalogChild("tours", "", "state",
                // catalog: findCatalog("quote_state"),
                filter: {"key": "date", "value": quoteDate.value}),
          ),
        ],
      ),
    );
  }
}

class QuoteHistoryTitle extends StatelessWidget {
  const QuoteHistoryTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.2,
        left: MediaQuery.of(context).size.width * 0.4,
      ),
      child: Text(
        'Quote History',
        style: KTextSytle(
          context: context,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 204, 164, 61),
        ).getStyle(),
      ),
    );
  }
}
