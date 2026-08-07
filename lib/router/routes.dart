import 'package:flowly/models/board_model.dart';
import 'package:flowly/screens/board_screen.dart';
import 'package:flowly/screens/create_board_screen.dart';
import 'package:flowly/screens/create_task_screen.dart';
import 'package:flowly/screens/home_screen.dart';
import 'package:flowly/screens/intro_screen.dart';
import 'package:flowly/screens/login_screen.dart';
import 'package:flowly/screens/name_screen.dart';
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
    GoRoute(path: '/name', builder: (context, state) => NameScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/createBoard',
      builder: (context, state) => CreateBoardScreen(),
    ),
    GoRoute(path: '/addTask', builder: (context, state) => CreateTaskScreen()),
    GoRoute(
      path: '/board',
      builder: (context, state) {
        final board = state.extra as Board;

        return BoardScreen(board: board);
      },
    ),
  ],
);
