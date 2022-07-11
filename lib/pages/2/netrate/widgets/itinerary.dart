import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/2/netrate/widgets/customdescription.dart';
import '../../../../index.dart';
import 'cover.dart';
import 'destinations.dart';
import 'header.dart';

class Itinerary extends StatelessWidget {
  Itinerary({Key? key, required this.pkeys}) : super(key: key);

  final _controller = ScrollController();
  final pkeys;
  @override
  Widget build(BuildContext context) {
    var totalNetRate = 0.obs;
    var netRate = globalctx.memory["netRate"];
    for (var item in netRate.entries) {
      totalNetRate.value += item.value as int;
    }

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.4,
          bottom: MediaQuery.of(context).size.height * 0.4),
      child: Stack(
        children: [
          Positioned(
            left: 100,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.2,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(children: [
                      RepaintBoundary(key: pkeys["cover"], child: Cover()),
                      RepaintBoundary(
                        key: pkeys["header"],
                        child: Header(),
                      ),
                      Destinations(),
                      CustomDescriptionWidget(
                          fontWeight: FontWeight.bold,
                          text: "Total Net Rate: $totalNetRate",
                          width: 0.55,
                          fontSize: 0.016),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
