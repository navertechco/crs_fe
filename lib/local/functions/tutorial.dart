import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// ooooooooooooo                 .                       o8o            oooo       oooooooooooo                                       .    o8o                                 
// 8'   888   `8               .o8                       `"'            `888       `888'     `8                                     .o8    `"'                                 
//      888      oooo  oooo  .o888oo  .ooooo.  oooo d8b oooo   .oooo.    888        888         oooo  oooo  ooo. .oo.    .ooooo.  .o888oo oooo   .ooooo.  ooo. .oo.    .oooo.o 
//      888      `888  `888    888   d88' `88b `888""8P `888  `P  )88b   888        888oooo8    `888  `888  `888P"Y88b  d88' `"Y8   888   `888  d88' `88b `888P"Y88b  d88(  "8 
//      888       888   888    888   888   888  888      888   .oP"888   888        888    "     888   888   888   888  888         888    888  888   888  888   888  `"Y88b.  
//      888       888   888    888 . 888   888  888      888  d8(  888   888        888          888   888   888   888  888   .o8   888 .  888  888   888  888   888  o.  )88b 
//     o888o      `V88V"V8P'   "888" `Y8bod8P' d888b    o888o `Y888""8o o888o      o888o         `V88V"V8P' o888o o888o `Y8bod8P'   "888" o888o `Y8bod8P' o888o o888o 8""888P' 
                                                                                                                                                                            
                                                                                                                                                                            
      

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
