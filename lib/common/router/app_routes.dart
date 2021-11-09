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
      name: '/Questionary',
      page: () => const QuestionaryPage(),
      transition: Transition.native,
      binding: QuestionaryBinding()),
  PRegistry(
      name: '/Splash',
      page: () => const SplashPage(),
      transition: Transition.native,
      binding: SplashBinding()),
  PRegistry(
      name: '/Dashboard',
      page: () => DashboardPage(),
      transition: Transition.native,
      binding: DashboardBinding()),
  PRegistry(
      name: '/Manual',
      page: () => const ManualPage(),
      transition: Transition.native,
      binding: ManualBinding()),
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
      name: '/Ranking',
      page: () => const RankingPage(),
      transition: Transition.native,
      binding: RankingBinding()),
  PRegistry(
      name: '/TournamentResult',
      page: () => const TournamentResultPage(),
      transition: Transition.native,
      binding: TournamentResultBinding()),
  PRegistry(
      name: '/Settings',
      page: () => const SettingsPage(),
      transition: Transition.native,
      binding: SettingsBinding()),
  PRegistry(
      name: '/Forgot',
      page: () => const ForgotPage(),
      transition: Transition.native,
      binding: ForgotBinding()),
  PRegistry(
      name: '/Terms',
      page: () => const TermsPage(),
      transition: Transition.native,
      binding: TermsBinding()),
  PRegistry(
      name: '/Survey',
      page: () => SurveyPage(),
      transition: Transition.native,
      binding: SurveyBinding()),
  PRegistry(
      name: '/Purpouses',
      page: () => const PurpousesPage(),
      transition: Transition.native,
      binding: PurpousesBinding()),
  PRegistry(
      name: '/Destinations',
      page: () => const DestinationsPage(),
      transition: Transition.native,
      binding: DestinationsBinding()),
  PRegistry(
      name: '/Activities',
      page: () => const ActivitiesPage(),
      transition: Transition.native,
      binding: ActivitiesBinding()),
  PRegistry(
      name: '/Opportunities',
      page: () => const OpportunitiesPage(),
      transition: Transition.native,
      binding: OpportunitiesBinding()),
];
