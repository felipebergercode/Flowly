import 'package:flowly/core/app_colors.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flowly/models/priority.dart';
import 'package:flutter/material.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BoardScreen extends StatefulWidget {
  final Board board;

  const BoardScreen({super.key, required this.board});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  bool _isDragging = false;

  // =====================================================
  // DRAG TARGET
  // =====================================================

  Widget _buildDropTarget(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required TaskStatus status,
  }) {
    return DragTarget<TaskModel>(
      // NO DEJA SOLTAR UNA TASK EN EL MISMO STATUS QUE YA TIENE
      onWillAcceptWithDetails: (details) {
        return details.data.status != status;
      },

      // CUANDO SOLTAMOS LA TASK
      onAcceptWithDetails: (details) {
        final task = details.data;

        context.read<TasksCubit>().changeTaskStatus(task.id, status);

        setState(() {
          _isDragging = false;
        });
      },

      builder: (context, candidateData, rejectedData) {
        // SI HAY UNA TASK ARRIBA DE ESTE TARGET
        final isHovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 68,
          decoration: BoxDecoration(
            color: isHovering ? color.withOpacity(0.22) : AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHovering ? color : Colors.white.withOpacity(0.12),
              width: isHovering ? 2 : 1,
            ),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isHovering ? color : Colors.white.withOpacity(0.45),
                size: 21,
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: TextStyle(
                  color: isHovering ? color : Colors.white.withOpacity(0.45),
                  fontFamily: 'Kanit',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
              // =====================================================
              // TOP BAR
              // =====================================================
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
                      color: widget.board.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.board.color.withOpacity(0.35),
                      ),
                    ),
                    child: Text(
                      'BOARD',
                      style: TextStyle(
                        color: widget.board.color,
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

              // =====================================================
              // BOARD HEADER
              // =====================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.board.color.withOpacity(0.25),
                      AppColors.card,
                    ],
                  ),
                  border: Border.all(
                    color: widget.board.color.withOpacity(0.40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.board.color.withOpacity(0.12),
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
                        color: widget.board.color,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: widget.board.color.withOpacity(0.35),
                            blurRadius: 18,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.board.icon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.board.name,
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
                            'Hold tight to move',
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
                              const _StatusDot(color: Colors.orange),

                              const SizedBox(width: 5),

                              const _StatusDot(color: Colors.blue),

                              const SizedBox(width: 5),

                              const _StatusDot(color: Colors.green),

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

              // =====================================================
              // PAGE VIEW
              // =====================================================
              Expanded(
                child: BlocBuilder<TasksCubit, List<TaskModel>>(
                  builder: (context, tasks) {
                    // -------------------------
                    // TO DO TASKS
                    // -------------------------

                    final todoTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == widget.board.id &&
                              task.status == TaskStatus.todo,
                        )
                        .toList();

                    // -------------------------
                    // IN PROGRESS TASKS
                    // -------------------------

                    final inProgressTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == widget.board.id &&
                              task.status == TaskStatus.inProgress,
                        )
                        .toList();

                    // -------------------------
                    // DONE TASKS
                    // -------------------------

                    final doneTasks = tasks
                        .where(
                          (task) =>
                              task.boardId == widget.board.id &&
                              task.status == TaskStatus.done,
                        )
                        .toList();

                    return PageView(
                      children: [
                        _TasksPage(
                          title: 'To Do',
                          color: Colors.orange,
                          tasks: todoTasks,

                          onDragStarted: () {
                            setState(() {
                              _isDragging = true;
                            });
                          },

                          onDragFinished: () {
                            setState(() {
                              _isDragging = false;
                            });
                          },
                        ),

                        _TasksPage(
                          title: 'In Progress',
                          color: Colors.blue,
                          tasks: inProgressTasks,

                          onDragStarted: () {
                            setState(() {
                              _isDragging = true;
                            });
                          },

                          onDragFinished: () {
                            setState(() {
                              _isDragging = false;
                            });
                          },
                        ),

                        _TasksPage(
                          title: 'Done',
                          color: Colors.green,
                          tasks: doneTasks,

                          onDragStarted: () {
                            setState(() {
                              _isDragging = true;
                            });
                          },

                          onDragFinished: () {
                            setState(() {
                              _isDragging = false;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),

              // =====================================================
              // DROP TARGETS
              // SOLO APARECEN CUANDO ARRASTRAMOS UNA TASK
              // =====================================================
              if (_isDragging) ...[
                const SizedBox(height: 12),

                Row(
                  children: [
                    // -------------------------
                    // TO DO
                    // -------------------------
                    Expanded(
                      child: _buildDropTarget(
                        context,
                        title: 'TO DO',
                        icon: Icons.list_alt_rounded,
                        color: Colors.orange,
                        status: TaskStatus.todo,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // -------------------------
                    // IN PROGRESS
                    // -------------------------
                    Expanded(
                      child: _buildDropTarget(
                        context,
                        title: 'PROGRESS',
                        icon: Icons.timelapse_rounded,
                        color: Colors.blue,
                        status: TaskStatus.inProgress,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // -------------------------
                    // DONE
                    // -------------------------
                    Expanded(
                      child: _buildDropTarget(
                        context,
                        title: 'DONE',
                        icon: Icons.check_rounded,
                        color: Colors.green,
                        status: TaskStatus.done,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// STATUS DOT
// =====================================================

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

// =====================================================
// TASKS PAGE
// =====================================================

class _TasksPage extends StatelessWidget {
  final String title;
  final Color color;
  final List<TaskModel> tasks;

  final VoidCallback onDragStarted;
  final VoidCallback onDragFinished;

  const _TasksPage({
    required this.title,
    required this.color,
    required this.tasks,
    required this.onDragStarted,
    required this.onDragFinished,
  });

  // =====================================================
  // PRIORITY COLOR
  // =====================================================

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

  // =====================================================
  // REUSABLE TASK CARD
  // =====================================================

  Widget _buildTaskCard(TaskModel task, Color priorityColor) {
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
          // -------------------------
          // TITLE
          // -------------------------
          Text(
            task.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
              fontFamily: 'Kanit',
            ),
          ),

          // -------------------------
          // DESCRIPTION
          // -------------------------
          if (task.description.isNotEmpty) ...[
            const SizedBox(height: 10),

            Text(
              task.description,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],

          const SizedBox(height: 12),

          // -------------------------
          // PRIORITY + DATE
          // -------------------------
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

              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.white38,
                size: 15,
              ),

              const SizedBox(width: 5),

              Text(
                DateFormat('MMM d').format(task.dueDate),
                style: const TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

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
            // =====================================================
            // PAGE HEADER
            // =====================================================
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

            // =====================================================
            // EMPTY
            // =====================================================
            if (tasks.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No tasks yet',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            // =====================================================
            // TASK LIST
            // =====================================================
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,

                  itemBuilder: (context, index) {
                    final TaskModel task = tasks[index];

                    final priorityColor = _getPriorityColor(task.priority);

                    // =====================================================
                    // LONG PRESS DRAGGABLE
                    // =====================================================

                    return LongPressDraggable<TaskModel>(
                      // TASK QUE ESTAMOS ARRASTRANDO
                      data: task,

                      // VIBRACION CUANDO EMPIEZA
                      hapticFeedbackOnStart: true,

                      // AVISAMOS A BOARD SCREEN
                      onDragStarted: onDragStarted,

                      // CUANDO TERMINA EL DRAG
                      onDragEnd: (_) {
                        onDragFinished();
                      },

                      // =====================================================
                      // CARD QUE SIGUE EL DEDO
                      // =====================================================
                      feedback: Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 300,
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: priorityColor,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: priorityColor.withOpacity(0.30),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // =====================================================
                      // CARD ORIGINAL MIENTRAS ARRASTRAMOS
                      // =====================================================
                      childWhenDragging: Opacity(
                        opacity: 0.20,
                        child: _buildTaskCard(task, priorityColor),
                      ),

                      // =====================================================
                      // CARD NORMAL
                      // =====================================================
                      child: _buildTaskCard(task, priorityColor),
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
