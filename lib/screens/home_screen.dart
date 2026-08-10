import 'package:dotted_border/dotted_border.dart';
import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/cubit/username/username_cubit.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flowly/screens/calendar_screen.dart';
import 'package:flowly/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeContent(),
      //Calendar Screen
      const CalendarScreen(),
      //Profile Screen
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      // =====================================================
      // ADD TASK BUTTON
      // =====================================================
      floatingActionButton: BlocBuilder<BoardsCubit, BoardsState>(
        builder: (context, state) {
          if (state.boards.isEmpty) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () {
              context.push('/addTask');
            },
            backgroundColor: AppColors.buttonPrimary,
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
      // =====================================================
      // SCREENS
      // =====================================================
      body: IndexedStack(index: _currentIndex, children: screens),
      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: AppColors.buttonPrimary,
                fontWeight: FontWeight.w600,
              );
            }

            return const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            );
          }),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.background,
          indicatorColor: Colors.transparent,
          height: 60,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.buttonPrimary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(
                Icons.calendar_month,
                color: AppColors.buttonPrimary,
              ),
              label: 'Calendar',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.buttonPrimary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
// =====================================================
// HOME CONTENT
// =====================================================

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            right: 10,
            left: 10,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // GOOD MORNING
              // =====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<UserNameCubit, UserNameState>(
                    builder: (context, state) {
                      return Text(
                        'Good morning, ${state.userName} 👋',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Kanit',
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                'Here\'s what\'s happening today.',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Your boards',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),
              // =====================================================
              // BOARDS
              // =====================================================
              BlocBuilder<BoardsCubit, BoardsState>(
                builder: (context, state) {
                  if (state.boards.isNotEmpty) {
                    final List<Widget> allItems = [
                      ...state.boards.map(
                        (board) => BoardContainer(
                          name: board.name,
                          color: board.color,
                          icon: board.icon,
                          board: board,
                        ),
                      ),
                      const ContainerNewBoard(),
                    ];

                    final List<Widget> rows = [];

                    for (int i = 0; i < allItems.length; i += 2) {
                      final bool isLast = i + 1 >= allItems.length;

                      rows.add(
                        Row(
                          children: [
                            Expanded(child: allItems[i]),
                            const SizedBox(width: 10),
                            isLast
                                ? const Expanded(child: SizedBox())
                                : Expanded(child: allItems[i + 1]),
                          ],
                        ),
                      );

                      if (i + 2 < allItems.length) {
                        rows.add(const SizedBox(height: 10));
                      }
                    }

                    return Column(children: rows);
                  }

                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<BoardsCubit, BoardsState>(
                builder: (context, state) {
                  if (state.boards.isEmpty) {
                    return GestureDetector(
                      onTap: () => context.push('/createBoard'),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.buttonSecondary,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create your first board',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Tap here to start organizing your tasks',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 30),
              BlocBuilder<BoardsCubit, BoardsState>(
                builder: (context, state) {
                  if (state.boards.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.buttonSecondary,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.35),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Turn your ideas into progress',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Flowly helps you organize your projects, manage your tasks and keep track of what needs to be done.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              height: 1.5,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'Stay organized and focused every day',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'Keep every task in one clear place',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'See what needs your attention next',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// =====================================================
// BOARD CONTAINER
// =====================================================

class BoardContainer extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final Board board;

  const BoardContainer({
    super.key,
    required this.name,
    required this.color,
    required this.icon,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/board', extra: board);
      },
      child: Container(
        width: 170,
        height: 125,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 23),
            ),

            const Spacer(),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 2),

            BlocBuilder<TasksCubit, List<TaskModel>>(
              builder: (context, state) {
                final boardTasks = state.where((task) {
                  return task.boardId == board.id;
                }).toList();
                return Text(
                  '${boardTasks.length} tasks',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// =====================================================
// NEW BOARD CONTAINER
// =====================================================

class ContainerNewBoard extends StatelessWidget {
  const ContainerNewBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: const Color(0xFF3B4252),
        strokeWidth: 1.2,
        dashPattern: const [5, 4],
        radius: const Radius.circular(18),
      ),
      child: GestureDetector(
        onTap: () {
          context.push('/createBoard');
        },
        child: Container(
          width: double.infinity,
          height: 125,
          decoration: BoxDecoration(
            color: const Color(0xFF11151F),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'New Board',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
