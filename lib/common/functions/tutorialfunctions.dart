import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../index.dart';

loadTargets() {
  var targets = <TargetFocus>[];
  targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: navBarKey,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ]));

  targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: navBarKey,
      contents: [
        TargetContent(
            align: ContentAlign.left,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
        TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ]));

  targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: navBarKey,
      contents: [
        TargetContent(
            align: ContentAlign.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title lorem ipsum",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ]));

  return targets;
}

void showTutorial(context) {
  TutorialCoachMark tutorial = TutorialCoachMark(context,
      targets: loadTargets(), // List<TargetFocus>
      colorShadow: Colors.red, // DEFAULT Colors.black
      // alignSkip: Alignment.bottomRight,
      // textSkip: "SKIP",
      // paddingFocus: 10,
      // focusAnimationDuration: Duration(milliseconds: 500),
      // unFocusAnimationDuration: Duration(millisconds: 500),
      // pulseAnimationDuration: Duration(milliseconds: 500),
      // pulseVariation: Tween(begin: 1.0, end: 0.99),
      onFinish: () {
    log("finish");
  }, onClickTargetWithTapPosition: (target, tapDetails) {
    log("target: $target");
    log("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
  }, onClickTarget: (target) {
    log(target);
  }, onSkip: () {
    log("skip");
  })
    ..show();

  // tutorial.skip();
  // tutorial.finish();
  // tutorial.next(); // call next target programmatically
  // tutorial.previous(); // call previous target programmatically
}
