// ignore_file: file_names
import 'package:flutter/material.dart';

import 'index.dart';



class DestinationListWidget extends StatelessWidget {
  const DestinationListWidget({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<DestinationOptionWidget> children;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.425,
              height: MediaQuery.of(context).size.height * 0.78, 
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Scrollbar(
                  child: SingleChildScrollView(
                      child: Column(children: children)))),
        ],
      ),
    );
  }
}
