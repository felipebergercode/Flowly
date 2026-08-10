import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/models/priority.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  Color _getStatusColor(TaskStatus task) {
    switch (task) {
      case TaskStatus.todo:
        return const Color.fromARGB(255, 236, 255, 22);

      case TaskStatus.inProgress:
        return AppColors.labelBlue;

      case TaskStatus.done:
        return AppColors.done;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          // =====================================================
          //CALENDAR FEAT
          // =====================================================
          child: BlocBuilder<TasksCubit, List<TaskModel>>(
            builder: (context, tasks) {
              final selectedTasks = tasks.where((task) {
                return isSameDay(task.dueDate, _selectedDay);
              }).toList();

              return Column(
                children: [
                  TableCalendar<TaskModel>(
                    firstDay: DateTime(2020),
                    lastDay: DateTime(2035),
                    focusedDay: _focusedDay,

                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },

                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },

                    eventLoader: (day) {
                      return tasks.where((task) {
                        return isSameDay(task.dueDate, day);
                      }).toList();
                    },

                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),

                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      outsideTextStyle: TextStyle(
                        color: Colors.white.withOpacity(0.20),
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF6366F1),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: Color(0xFF818CF8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =====================================================
                  // BELOW CONTAINERS (BOARD EMPTY)
                  // =====================================================
                  BlocBuilder<BoardsCubit, BoardsState>(
                    builder: (context, boardState) {
                      if (boardState.boards.isEmpty) {
                        return GestureDetector(
                          onTap: () => context.push('/createBoard'),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.4),
                              ),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.dashboard_outlined,
                                  color: AppColors.primary,
                                  size: 34,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Create your first board',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Create a board before adding your first task.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      // =====================================================
                      //BOARD EMPTY
                      // =====================================================

                      if (tasks.isEmpty) {
                        return GestureDetector(
                          onTap: () => context.push('/addTask'),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.4),
                              ),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.add_task,
                                  color: AppColors.primary,
                                  size: 34,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Add your first task',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Your tasks will appear here on the calendar.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontFamily: 'Kanit',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),

                  const SizedBox(height: 30),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDay != null
                                ? DateFormat(
                                    'MMMM d, yyyy',
                                  ).format(_selectedDay!)
                                : '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedTasks.length,
                      itemBuilder: (context, index) {
                        final task = selectedTasks[index];

                        final priorityColor = _getPriorityColor(task.priority);

                        final statusColor = _getStatusColor(task.status);

                        final boards = context.read<BoardsCubit>().state.boards;

                        final board = boards.firstWhere(
                          (board) => board.id == task.boardId,
                        );

                        // =====================================================
                        //TASK CARDS
                        // =====================================================

                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonPrimary),
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    board.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                  Icon(board.icon, color: Colors.white),
                                ],
                              ),

                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Kanit',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    task.status.name.toUpperCase(),
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 16,
                                      fontFamily: 'Kanit',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.description,
                                      style: const TextStyle(
                                        fontFamily: 'Kanit',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    task.priority.name.toUpperCase(),
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontFamily: 'Kanit',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
