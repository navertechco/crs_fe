import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  final service;

  @override
  Widget build(BuildContext context) {
    var srvData = filteredsrv
        .toList()
        .firstWhere((srv) => srv.description == service)
        .value;
    return Text("$service",
        style: KTextSytle(
                context: context,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 128, 128, 128))
            .getStyle());
  }
}
