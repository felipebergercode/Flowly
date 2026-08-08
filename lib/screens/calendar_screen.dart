import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/models/priority.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

                    // =========================
                    // DÍA SELECCIONADO
                    // =========================
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },

                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },

                    // =========================
                    // TASKS DE CADA DÍA
                    // =========================
                    eventLoader: (day) {
                      return tasks.where((task) {
                        return isSameDay(task.dueDate, day);
                      }).toList();
                    },

                    // =========================
                    // HEADER
                    // =========================
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

                    // =========================
                    // MON, TUE, WED...
                    // =========================
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

                    // =========================
                    // ESTILO DEL CALENDARIO
                    // =========================
                    calendarStyle: CalendarStyle(
                      // DÍAS NORMALES
                      defaultTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),

                      // FIN DE SEMANA
                      weekendTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),

                      // DÍAS DE OTRO MES
                      outsideTextStyle: TextStyle(
                        color: Colors.white.withOpacity(0.20),
                      ),

                      // DÍA DE HOY
                      todayDecoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),

                      todayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),

                      // DÍA SELECCIONADO
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF6366F1),
                        shape: BoxShape.circle,
                      ),

                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),

                      // PUNTITOS DE TASKS
                      markerDecoration: const BoxDecoration(
                        color: Color(0xFF818CF8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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
                          Text(
                            textAlign: TextAlign.start,
                            tasks.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Kanit',
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
                                  SizedBox(width: 20),
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
