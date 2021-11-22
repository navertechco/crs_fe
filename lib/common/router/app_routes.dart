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
      name: '/Home',
      page: () => const HomePage(),
      transition: Transition.native,
      binding: HomeBinding()),
  PRegistry(
      name: '/Signin',
      page: () => const SigninPage(),
      transition: Transition.native,
      binding: SigninBinding()),
  PRegistry(
      name: '/Signup',
      page: () => const SignupPage(),
      transition: Transition.native,
      binding: SignupBinding()),
  PRegistry(
      name: '/Splash',
      page: () => const SplashPage(),
      transition: Transition.native,
      binding: SplashBinding()),

  PRegistry(
      name: '/Policies',
      page: () => const PoliciesPage(),
      transition: Transition.native,
      binding: PoliciesBinding()),
  PRegistry(
      name: '/Profile',
      page: () => ProfilePage(),
      transition: Transition.native,
      binding: ProfileBinding()),
  PRegistry(
      name: '/Forgot',
      page: () => const ForgotPage(),
      transition: Transition.native,
      binding: ForgotBinding()),
  PRegistry(
      name: '/Purpouses',
      page: () => const PurpousesPage(),
      transition: Transition.native,
      binding: PurpousesBinding()),
  PRegistry(
      name: '/Destination',
      page: () => const DestinationPage(),
      transition: Transition.native,
      binding: DestinationBinding()),
  PRegistry(
      name: '/Activities',
      page: () => const ActivitiesPage(),
      transition: Transition.native,
      binding: ActivitiesBinding()),
  PRegistry(
      name: '/DGallery',
      page: () => DGalleryPage(),
      transition: Transition.native,
      binding: DGalleryBinding()),
  PRegistry(
      name: '/Loading',
      page: () => LoadingPage(),
      transition: Transition.native,
      binding: LoadingBinding()),
  PRegistry(
      name: '/Congrats',
      page: () => CongratsPage(),
      transition: Transition.native,
      binding: CongratsBinding()),
  PRegistry(
      name: '/Resume',
      page: () => ResumePage(),
      transition: Transition.native,
      binding: ResumeBinding()),
  PRegistry(
      name: '/Arrival',
      page: () => ArrivalPage(),
      transition: Transition.native,
      binding: ArrivalBinding()),
  PRegistry(
      name: '/Customer',
      page: () => CustomerPage(),
      transition: Transition.native,
      binding: CustomerBinding()),
];
