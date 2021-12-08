import 'package:flutter/material.dart';
import 'package:naver_crs/common/index.dart';
import 'index.dart';

class CustomParentStarDestinationForm extends StatelessWidget {
  const CustomParentStarDestinationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> destinations = getContext("destinations");
    List<Widget> destinationlist = [];
    destinations.keys.forEach((key) {
      destinationlist.add(
        CustomStarDestinationForm(destination: key),
      );
    });

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.18,
      left: MediaQuery.of(context).size.width * 0.55,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.75,
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
                    const CustomKeypadWidget(),
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
