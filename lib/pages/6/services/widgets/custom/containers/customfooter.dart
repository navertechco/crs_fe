import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class CustomFooterWidget extends StatelessWidget {
  final ServicesController ctrl;
  final ValueNotifier<int> counter;
  const CustomFooterWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: 100, height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
        Row(
          children: [
            TextButton(
              child: Text("Previous",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () async {
                await paginateDestination("prev");
              },
            ),
            TextButton(
              child: Text("Reset",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () {
                resetServices();
              },
            ),
            TextButton(
              child: Text("Next",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle()),
              onPressed: () async {
                await paginateDestination("next");
              },
            ),
          ],
        ),
      ],
    );
  }
}
