part of './app_pages.dart';

class PRegistry {
  PRegistry({this.name, this.page, this.transition, this.binding});
  final String? name;
  final dynamic page;
  final dynamic transition;
  final dynamic binding;
}

List<dynamic> routes = [
  PRegistry(
      name: '/Splash',
      page: () => const SplashPage(),
      transition: Transition.rightToLeftWithFade,
      binding: SplashBinding()),
  PRegistry(
      name: '/Signin',
      page: () => const SigninPage(),
      transition: Transition.rightToLeftWithFade,
      binding: SigninBinding()),
  PRegistry(
      name: '/Forgot',
      page: () => const ForgotPage(),
      transition: Transition.rightToLeftWithFade,
      binding: ForgotBinding()),
  PRegistry(
      name: '/Loading',
      page: () => const LoadingPage(),
      transition: Transition.rightToLeftWithFade,
      binding: LoadingBinding()),
  PRegistry(
      name: '/Tour',
      page: () => const TourPage(),
      transition: Transition.rightToLeftWithFade,
      binding: TourBinding()),
  PRegistry(
      name: '/Logistic',
      page: () => const LogisticPage(),
      transition: Transition.rightToLeftWithFade,
      binding: LogisticBinding()),
  PRegistry(
      name: '/Customer',
      page: () => const CustomerPage(),
      transition: Transition.rightToLeftWithFade,
      binding: CustomerBinding()),
  PRegistry(
      name: '/Destination',
      page: () => const DestinationPage(),
      transition: Transition.rightToLeftWithFade,
      binding: DestinationBinding()),
  PRegistry(
      name: '/Experiences',
      page: () => const ExperiencesPage(),
      transition: Transition.rightToLeftWithFade,
      binding: ExperiencesBinding()),
  PRegistry(
      name: '/Resume',
      page: () => ResumePage(),
      transition: Transition.rightToLeftWithFade,
      binding: ResumeBinding()),
  PRegistry(
      name: '/NetRate',
      page: () => NetRatePage(),
      transition: Transition.rightToLeftWithFade,
      binding: NetRateBinding()),
  PRegistry(
      name: '/Searcher',
      page: () => SearcherPage(),
      transition: Transition.rightToLeftWithFade,
      binding: SearcherBinding()),
];
