import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'index.dart';

class CustomRightStarDestinationForm extends StatelessWidget {
  const CustomRightStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DestinationsOrderableListWidget(),
        // DestinationListScroll(),
        const ResetPadWidget(),

        const KeyPadWidget(),
      ],
    );
  }
}

class ResetPadWidget extends StatelessWidget {
  const ResetPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.0,
        left: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Obx(() {
        if (!globalctx.destinationlist.isNotEmpty) {
          return CustomKeypadWidget(
              prevlabel: "< Reset >",
              nextlabel: "",
              onPrevious: () {
                globalctx.Completed.value = [];
                globalctx.Keys.value = [];
                globalctx.destinationDragData.value = [];
              },
              width: 0.01);
        }
        return const Text("");
      }),
    );
  }
}

class KeyPadWidget extends StatelessWidget {
  const KeyPadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.0,
        left: MediaQuery.of(context).size.width * 0.51,
      ),
      child: Obx(() {
        if (!globalctx.destinationlist.isNotEmpty) {
          return CustomKeypadWidget(
              prevlabel: "< Previous",
              nextlabel: "Next >",
              onNext: () {
                Get.toNamed("/Activities");
              },
              onPrevious: () {
                Get.back();
              },
              width: 0.3);
        }
        return const Text("");
      }),
    );
  }
}

class DestinationListScroll extends StatelessWidget {
  const DestinationListScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    List<Widget> destinationlist = [];
    for (var key in destinations.keys) {
      destinationlist.add(
        CustomStarDestinationForm(destination: key),
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: MediaQuery.of(context).size.width * 0.5,
      ),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.5,
              // margin: const EdgeInsets.all(15.0),
              // padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Scrollbar(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Column(children: destinationlist),
                    Obx(() {
                      if (globalctx.destinationlist.isNotEmpty) {
                        return CustomKeypadWidget(
                            onNext: () {
                              Get.toNamed("/Activities");
                            },
                            onPrevious: () {
                              Get.back();
                            },
                            width: 0.1);
                      }
                      return const Text("");
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    )
                  ],
                )),
              )),
        ],
      ),
    );
  }
}

class DestinationsOrderableListWidget extends StatefulWidget {
  List<String> item = [
    "Clients",
    "Designer",
    "Developer",
  ];
  @override
  _DestinationsOrderableListWidgetState createState() =>
      _DestinationsOrderableListWidgetState();
}

class _DestinationsOrderableListWidgetState
    extends State<DestinationsOrderableListWidget> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.item.removeAt(oldindex);
      widget.item.insert(newindex, items);
    });
  }

  void sorting() {
    setState(() {
      widget.item.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.16,
          left: MediaQuery.of(context).size.width * 0.46,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.46,
            child: DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.35,
                  color: Colors.grey[50],
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Obx(() {
                      return SingleChildScrollView(
                        child: Column(
                            children: globalctx.destinationDragData.value),
                      );
                    }),
                  ),
                );
              },
              onAccept: (String key) {
                if (!globalctx.Keys.contains(key)) {
                  globalctx.Keys.add(key);
                  globalctx.destinationDragData.value.add(Obx(() {
                    return globalctx.Keys.contains(key)
                        ? Row(
                            children: [
                              DestinationOptionWidget(destination: key),
                              !globalctx.Completed.contains(key)
                                  ? GestureDetector(
                                      onTap: () {
                                        if (globalctx.Keys.contains(key)) {
                                          var index = globalctx.Keys.indexWhere(
                                              (element) => element == key);
                                          globalctx.Keys.removeAt(index);
                                          globalctx.destinationDragData.value
                                              .removeAt(index);
                                        }
                                      },
                                      child: Image.asset(
                                          "assets/custom/img/redmark.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (globalctx.Keys.contains(key)) {
                                          globalctx.Completed.remove(key);
                                          var index = globalctx.Keys.indexWhere(
                                              (element) => element == key);
                                          globalctx.Keys.removeAt(index);
                                          globalctx.destinationDragData.value
                                              .removeAt(index);
                                        }
                                      },
                                      child: Image.asset(
                                          "assets/custom/img/greencheck.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                    )
                            ],
                          )
                        : Text("");
                  }));
                }
              },
            )));
  }
}
