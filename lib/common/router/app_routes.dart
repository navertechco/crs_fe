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
      transition: Transition.native,
      binding: SplashBinding()),
  PRegistry(
      name: '/Signin',
      page: () => const SigninPage(),
      transition: Transition.native,
      binding: SigninBinding()),
  PRegistry(
      name: '/Forgot',
      page: () => const ForgotPage(),
      transition: Transition.native,
      binding: ForgotBinding()),
  PRegistry(
      name: '/Loading',
      page: () => const LoadingPage(),
      transition: Transition.native,
      binding: LoadingBinding()),
  PRegistry(
      name: '/Tour',
      page: () => const TourPage(),
      transition: Transition.native,
      binding: TourBinding()),
  PRegistry(
      name: '/Logistic',
      page: () => const LogisticPage(),
      transition: Transition.native,
      binding: LogisticBinding()),
  PRegistry(
      name: '/Customer',
      page: () => const CustomerPage(),
      transition: Transition.native,
      binding: CustomerBinding()),
  PRegistry(
      name: '/Destination',
      page: () => const DestinationPage(),
      transition: Transition.native,
      binding: DestinationBinding()),
  PRegistry(
      name: '/Experiences',
      page: () => const ExperiencesPage(),
      transition: Transition.native,
      binding: ExperiencesBinding()),
  PRegistry(
      name: '/Resume',
      page: () => ResumePage(),
      transition: Transition.native,
      binding: ResumeBinding()),
  PRegistry(
      name: '/NetRate',
      page: () => NetRatePage(),
      transition: Transition.native,
      binding: NetRateBinding()),
];
