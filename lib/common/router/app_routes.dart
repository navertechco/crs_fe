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
      name: '/Forgot',
      page: () => const ForgotPage(),
      transition: Transition.native,
      binding: ForgotBinding()),
  PRegistry(
      name: '/Destination',
      page: () => const DestinationPage(),
      transition: Transition.native,
      binding: DestinationBinding()),
  PRegistry(
      name: '/DestinationDetail',
      page: () => const DestinationDetailPage(),
      transition: Transition.native,
      binding: DestinationDetailBinding()),
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
      page: () => const LoadingPage(),
      transition: Transition.native,
      binding: LoadingBinding()), 
  PRegistry(
      name: '/Resume',
      page: () => ResumePage(),
      transition: Transition.native,
      binding: ResumeBinding()),
  PRegistry(
      name: '/Arrival',
      page: () => const ArrivalPage(),
      transition: Transition.native,
      binding: ArrivalBinding()),
  PRegistry(
      name: '/Customer',
      page: () => const CustomerPage(),
      transition: Transition.native,
      binding: CustomerBinding()),
  PRegistry(
      name: '/TourParameters',
      page: () => const TourParametersPage(),
      transition: Transition.native,
      binding: TourParametersBinding()),
];
