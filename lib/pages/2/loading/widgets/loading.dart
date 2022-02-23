import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import '../../../index.dart';

/// Loading
// ignore: must_be_immutable
class LoadingWidget extends GetView<LoadingController> {
  LoadingWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  LoadingController ctrl;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyLayoutWidget(
          background: "assets/custom/img/loading.png",
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.4,
                      top: MediaQuery.of(context).size.height * 0.62),
                  child: RoundedFormField(
                      onChanged: (value) => ctrl.state.tourId = value!,
                      hintText: 'Search Quote',
                      keyboardType: TextInputType.number)),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.4,
                    top: MediaQuery.of(context).size.height * 0.7),
                child: RoundedFormButton(
                    label: "Go",
                    height: 0.07,
                    fontSize: 7,
                    onTap: () {
                      ctrl.getTour(tourId: int.parse(ctrl.state.tourId));
                    }),
              ),
            ],
          )),
    );
  }
}
