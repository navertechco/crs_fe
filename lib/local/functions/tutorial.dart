import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// ████████╗██╗   ██╗████████╗ ██████╗ ██████╗ ██╗ █████╗ ██╗                
// ╚══██╔══╝██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗██║██╔══██╗██║                
//    ██║   ██║   ██║   ██║   ██║   ██║██████╔╝██║███████║██║                
//    ██║   ██║   ██║   ██║   ██║   ██║██╔══██╗██║██╔══██║██║                
//    ██║   ╚██████╔╝   ██║   ╚██████╔╝██║  ██║██║██║  ██║███████╗           
//    ╚═╝    ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝           
                                                                          
// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝                                                                                                                                                                      
      

/// ## loadTargets
/// *__Auxiliary Method to display Tutorial__*
///
///
///### Uses:
/// ```dart
///   targets: loadTargets(),
/// ```
///
/// @return List<TargetFocus>
///
List<TargetFocus> loadTargets() {
  List<TargetFocus> targets = <TargetFocus>[];

  for (var page in pageList) {
    targets.add(TargetFocus(
      identify: page["label"],
      keyTarget: page["key"],
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              page["label"],
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
          ),
        ),
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  return targets;
}

/// ## showTutorial
/// *__Method to display Tutorial__*
///
/// 
///
///### Uses:
/// ```dart
///   if (isFirstLaunch) {
///   showTutorial(context);
/// }
/// ```
///
/// @return void
///
void showTutorial(BuildContext context) {
  TutorialCoachMark(context,
      textStyleSkip: TextStyle(color: Colors.black, fontSize: 50),
      targets: loadTargets(),
      colorShadow: Colors.grey.shade200, onFinish: () {
    isFirstLaunch = false;
    log("finish");
  }, onClickTargetWithTapPosition: (target, tapDetails) {
    log("target: $target");
    log("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
  }, onClickTarget: (target) {
    log(target);
  }, onSkip: () {
    isFirstLaunch = false;
    log("skip");
  }).show();
}
