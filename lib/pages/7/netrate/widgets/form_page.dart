// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../index.dart';
import '../controller.dart';

class NetRateFormPage extends GetView<StatelessWidget> {
  NetRateFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final NetRateController? ctrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                WebButton(
                    label: "PDF Resume",
                    color: Color.fromARGB(255, 204, 164, 61),
                    url:
                        "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/pdf.html"),
                SizedBox(height: kDefaultPadding),
                WebButton(
                    label: "WORD Resume",
                    color: Color.fromARGB(255, 204, 164, 61),
                    url:
                        "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/docx.html"),
                SizedBox(height: kDefaultPadding),
                WebButton(
                    label: "Video Gallery",
                    color: Color.fromARGB(255, 204, 164, 61),
                    url:
                        "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/Client/PlayTour/6ba7b811-9dad-11d1-80b4-00c04fd430c8"),
                SizedBox(height: kDefaultPadding),
                WebButton(
                    label: "Photo Gallery",
                    color: Color.fromARGB(255, 204, 164, 61),
                    url:
                        "$kDefaultSchema://$kDefaultServer:$kDefaultServerPort/gallery.html"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WebButton extends StatelessWidget {
  const WebButton({
    Key? key,
    required this.color,
    required this.label,
    required this.url,
  }) : super(key: key);
  final  color;
  final String label;
  final String url;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: RoundedFormButton(
        color: color,
        label: label,
        height: 0.07,
        fontSize: 5,
        onTap: () async {
          showCustomDialog(context, WebView(url: url), "Close",
              buttonColor: Colors.white);
        },
      ),
    );
  }
}

class WebView extends StatelessWidget {
  WebView({Key? key, required this.url}) : super(key: key);
  final String url;
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(
            url: Uri.parse(url),
          ))
    ]));
  }
}
