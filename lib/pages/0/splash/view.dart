import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (1)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Lottie.asset(
            'assets/splash_lottie.json',
            controller: _controller,
            height: MediaQuery.of(context).size.height * 1,
            repeat: true,
            reverse: true,
            animate: true,
            onLoaded: (composition) {
              _controller
                ?..duration = composition.duration
                ..forward().whenComplete(() => Get.toNamed("/Signin"));
            },
          ),
        ));
  }
}
