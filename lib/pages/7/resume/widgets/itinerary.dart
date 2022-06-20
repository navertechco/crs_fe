import 'package:flutter/material.dart';
import 'cover.dart';
import 'destinations.dart';
import 'header.dart';

class Itinerary extends StatelessWidget {
  Itinerary({Key? key, required this.pkeys}) : super(key: key);

  final _controller = ScrollController();
  final pkeys;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
      child: Stack(
        children: [
          Positioned(
            left: 100,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.5,
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
