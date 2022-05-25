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
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.8,
                  left: MediaQuery.of(context).size.width * 0.8,
                ),
                child: TextButton(
                  onPressed: () {
                    showCustomDialog(
                        context,
                        SearcherWidget(
                          ctrl: controller,
                        ),
                        "Close",
                        width: 1,
                        height: 1);
                  },
                  child: Text('Display',
                      style: KTextSytle(
                        context: context,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61),
                      ).getStyle()),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
