import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import '../../../index.dart';

/// Loading
class LoadingWidget extends GetView<LoadingController> {
  LoadingWidget({
    Key? key,
    required this.state,
  }) : super(key: key); 
  LoadingState state;

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
                  onSaved: (value) => state.title = value!,
                  hintText: 'Search Quote',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.4,
                    top: MediaQuery.of(context).size.height * 0.7),
                child: RoundedFormButton(
                    label: "Go",
                    height: 0.07,
                    fontSize: 12,
                    onTap: () {
                      controller.getTour();
                    }),
              ),
            ],
          )),
    );
  }
}
