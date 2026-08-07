import 'package:flowly/core/app_colors.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flowly/models/priority.dart';
import 'package:flutter/material.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BoardScreen extends StatelessWidget {
  final Board board;

  const BoardScreen({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 30,
          ),
          child: Column(
            children: [
              // =========================
              // FIXED TOP SECTION
              // =========================
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white70,
                        size: 17,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: board.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: board.color.withOpacity(0.35)),
                    ),
                    child: Text(
                      'BOARD',
                      style: TextStyle(
                        color: board.color,
                        fontSize: 11,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [board.color.withOpacity(0.25), AppColors.card],
                  ),

                  border: Border.all(color: board.color.withOpacity(0.40)),

                  boxShadow: [
                    BoxShadow(
                      color: board.color.withOpacity(0.12),
                      blurRadius: 25,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: board.color,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: board.color.withOpacity(0.35),
                            blurRadius: 18,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(board.icon, color: Colors.white, size: 32),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            board.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 26,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            'Manage your workflow',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.50),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              _StatusDot(color: Colors.orange),

                              const SizedBox(width: 5),

                              _StatusDot(color: Colors.blue),

                              const SizedBox(width: 5),

                              _StatusDot(color: Colors.green),

                              const SizedBox(width: 8),

                              Text(
                                'To Do  •  Progress  •  Done',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.40),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =========================
              // PAGE VIEW
              // =========================
              Expanded(
                child: BlocBuilder<TasksCubit, List<TaskModel>>(
                  builder: (context, tasks) {
                    final todoTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == board.id &&
                              task.status == TaskStatus.todo,
                        )
                        .toList();

                    final inProgressTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == board.id &&
                              task.status == TaskStatus.inProgress,
                        )
                        .toList();

                    final doneTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == board.id &&
                              task.status == TaskStatus.done,
                        )
                        .toList();

                    return PageView(
                      children: [
                        _TasksPage(
                          title: 'To Do',
                          color: Colors.orange,
                          tasks: todoTasks,
                        ),

                        _TasksPage(
                          title: 'In Progress',
                          color: Colors.blue,
                          tasks: inProgressTasks,
                        ),

                        _TasksPage(
                          title: 'Done',
                          color: Colors.green,
                          tasks: doneTasks,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================
// SMALL STATUS DOT
// =========================

class _StatusDot extends StatelessWidget {
  final Color color;

  const _StatusDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// =========================
// TASK PAGE
// =========================

class _TasksPage extends StatelessWidget {
  final String title;
  final Color color;
  final List<TaskModel> tasks;

  const _TasksPage({
    required this.title,
    required this.color,
    required this.tasks,
  });

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return const Color(0xFF4CAF50);

      case Priority.medium:
        return const Color(0xFFFF9800);

      case Priority.high:
        return const Color(0xFFF44336);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${tasks.length}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (tasks.isEmpty)
              Center(
                child: Text(
                  'No tasks yet',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    final priorityColor = _getPriorityColor(task.priority);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: priorityColor),
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Kanit',
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            task.description,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Text(
                                task.priority.name.toUpperCase(),
                                style: TextStyle(
                                  color: priorityColor,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const Spacer(),

                              Text(
                                DateFormat('MMM d').format(task.dueDate),
                                style: const TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
