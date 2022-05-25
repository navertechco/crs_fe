import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';
import 'index.dart';
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
              QuoteHistoryButton(),
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
      child: Obx(() {
        if (quoteDisplay.value) {
          return SearcherWidget(
            ctrl: controller,
          );
        } else {
          return Text("");
        }
      }),
    );
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 204, 164, 61),
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
                  findMemoryChildCatalog(
                    "tours",
                    "",
                    "date",
                  ),
                  value);
              filterCruises(context);
            },
            hintText: "Quote Date",
            data: findMemoryChildCatalog(
              "tours",
              "",
              "date",
            ),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Date is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteDate.value = getCatalogDescription(
                  findMemoryChildCatalog(
                    "tours",
                    "",
                    "date",
                  ),
                  value);
              filterCruises(context);
            },
            hintText: "Quote Date",
            data: findMemoryChildCatalog(
              "tours",
              "",
              "date",
            ),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Date is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteDate.value = getCatalogDescription(
                  findMemoryChildCatalog(
                    "tours",
                    "",
                    "date",
                  ),
                  value);
              filterCruises(context);
            },
            hintText: "Quote Date",
            data: findMemoryChildCatalog(
              "tours",
              "",
              "date",
            ),
          ),
          CustomFormDropDownFieldWidget(
            width: 0.1,
            height: 0.05,
            validator: CustomRequiredValidator(
                errorText: "Quote Date is required ", ctx: context),
            value: "0",
            onSaved: (value) {},
            onChanged: (value) {
              quoteDate.value = getCatalogDescription(
                  findMemoryChildCatalog(
                    "tours",
                    "",
                    "date",
                  ),
                  value);
              filterCruises(context);
            },
            hintText: "Quote Date",
            data: findMemoryChildCatalog(
              "tours",
              "",
              "date",
            ),
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
