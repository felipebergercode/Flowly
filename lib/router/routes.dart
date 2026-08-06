import 'package:flowly/screens/home_screen.dart';
import 'package:flowly/screens/intro_screen.dart';
import 'package:flowly/screens/login_screen.dart';
import 'package:flowly/screens/register_screen.dart';
import 'package:flowly/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => IntroScreen()),
    GoRoute(path: '/welcome', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
