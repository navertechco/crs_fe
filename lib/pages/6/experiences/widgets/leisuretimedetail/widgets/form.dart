import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';
import 'index.dart';

class CustomLeisureTimeDetailForm extends StatelessWidget {
  CustomLeisureTimeDetailForm({Key? key, this.ctrl, required this.experience})
      : super(key: key);

  final LeisureTimeDetailController? ctrl;
  final _formKey = GlobalKey<FormState>();
  final String experience;
  final TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextButton(
                  child: Text("Start",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                  },
                ),
                TextButton(
                  child: Text("End",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                  },
                ),
              ],
            )),
      ],
    );
  }
}
