import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

class BottonNavWidget extends StatelessWidget {
  const BottonNavWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List Routes = [
      '/Dashboard',
      '/Profile',
      '/Settings',
      '/Settings',
      '/Settings',
      '/Settings',
    ];
    int idx = getContext('index');

    return BottomNavigationBar(
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/custom/svg/images/white_rounded_squares.svg',
              width: MediaQuery.of(context).size.width * 0.05),
          label: ('Dashboard'),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/custom/svg/images/white_chart.svg',
              width: MediaQuery.of(context).size.width * 0.05),
          label: ('Reports'),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/custom/svg/images/white_talking_people.svg',
              width: MediaQuery.of(context).size.width * 0.05),
          label: ('Talking'),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
              'assets/custom/svg/images/white_archive_persone.svg',
              width: MediaQuery.of(context).size.width * 0.05),
          label: ('History'),
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/custom/svg/images/white_video.svg',
              width: MediaQuery.of(context).size.width * 0.05),
          label: ('Video'),
          backgroundColor: Colors.black,
        ),
      ],
      currentIndex: idx,
      selectedItemColor: Colors.white,
      onTap: (index) {
        idx = index;
        setContext('index', idx);

        Get.toNamed(Routes[idx]);
      },
    );
  }
}
