import 'package:go_router/go_router.dart';
import 'package:kwaze_kreyol/main.dart';
import 'package:kwaze_kreyol/screens/iam/auth_screen.dart';
import 'package:kwaze_kreyol/screens/profile/profile_screen.dart';
import 'package:kwaze_kreyol/widgets/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    // Ajoute d'autres routes comme /play etc.
  ],
);
