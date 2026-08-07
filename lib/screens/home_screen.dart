import 'package:dotted_border/dotted_border.dart';
import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/cubit/username/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/addTask');
        },
        backgroundColor: AppColors.buttonPrimary,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            right: 10,
            left: 10,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<UserNameCubit, UserNameState>(
                    builder: (context, state) {
                      return Text(
                        'Good morning, ${state.userName} 👋',
                        style: TextStyle(
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
                      icon: Icon(
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
              SizedBox(height: 30),
              Text(
                'Your boards',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              BlocBuilder<BoardsCubit, BoardsState>(
                builder: (context, state) {
                  final allItems = [
                    ...state.boards.map(
                      (board) => BoardContainer(
                        name: board.name,
                        color: board.color,
                        icon: board.icon,
                      ),
                    ),
                    ContainerNewBoard(),
                  ];

                  final rows = <Widget>[];
                  for (int i = 0; i < allItems.length; i += 2) {
                    final isLast = i + 1 >= allItems.length;
                    rows.add(
                      Row(
                        children: [
                          Expanded(child: allItems[i]),
                          const SizedBox(width: 10),
                          // fill second slot with empty space if only one item in row
                          isLast
                              ? const Expanded(child: SizedBox())
                              : Expanded(child: allItems[i + 1]),
                        ],
                      ),
                    );
                    if (i + 2 < allItems.length)
                      rows.add(const SizedBox(height: 10));
                  }

                  return Column(children: rows);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardContainer extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;

  const BoardContainer({
    super.key,
    required this.name,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),

          const Spacer(),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            '0 tasks',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerNewBoard extends StatelessWidget {
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
        onTap: () => context.push('/createBoard'),
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
                  "New Board",
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
