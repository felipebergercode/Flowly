import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/cubit/date/date_cubit.dart';
import 'package:flowly/cubit/description/description_cubit.dart';
import 'package:flowly/cubit/priority/priority_cubit.dart';
import 'package:flowly/cubit/title/title_cubit.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flowly/widgets/priority_containers.dart';
import 'package:flutter/material.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flowly/models/priority.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Board? _selectedBoard;
  DateTime? _selectedDate;
  bool _boardError = false;
  bool _dateError = false;
  bool _titleError = false;

  void _pickBoard(List<Board> boards) {
    if (boards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must create a board first before adding a task.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.buttonSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: boards
            .map(
              (b) => ListTile(
                leading: Icon(b.icon, color: b.color),
                title: Text(
                  b.name,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    _selectedBoard = b;
                    _boardError = false;
                  });
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  // FUNCION PARA ELEGIR FECHA
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.dark(
            primary: AppColors.primaryLight,
            onPrimary: Colors.white,
            surface: AppColors.buttonSecondary,
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      context.read<DateCubit>().selectDate(picked);
    }
    ;
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _dateError = false;
      });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.only(right: 10, left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Text(
                      'Add new task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                //TITLE AND TEXTFIELD
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: _titleError
                            ? Border.all(color: Colors.redAccent)
                            : null,
                        color: AppColors.buttonSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'eg. Fix Ul bugs',
                            ),
                            controller: null,
                            onChanged: (value) {
                              context.read<TitleCubit>().saveTitle(value);
                              if (value.isNotEmpty && _titleError)
                                setState(() => _titleError = false);
                            },
                          ),
                        ),
                      ),
                    ),
                    if (_titleError)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          'Please enter a title',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                //DESCRIPTION AND TEXTFIELD
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.buttonSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add a more detailed description..',
                          ),
                          onChanged: (value) => context
                              .read<DescriptionCubit>()
                              .saveDescription(value),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //BOARD AND SELECT BOARD
                Text(
                  'Board',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                BlocBuilder<BoardsCubit, BoardsState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _pickBoard(state.boards),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.buttonSecondary,
                              borderRadius: BorderRadius.circular(10),
                              border: _boardError
                                  ? Border.all(color: Colors.redAccent)
                                  : null,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedBoard?.name ??
                                      'Choose any of your board',
                                  style: TextStyle(
                                    color: _selectedBoard != null
                                        ? Colors.white
                                        : Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.expand_more,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_boardError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 4),
                            child: Text(
                              'Please select a board',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                //PRIORITY CHOOSE
                BlocBuilder<PriorityCubit, Priority>(
                  builder: (context, state) {
                    return PriorityContainers(
                      onChanged: (p) =>
                          context.read<PriorityCubit>().selectPriority(p),
                    );
                  },
                ),
                SizedBox(height: 20),
                //DUE DATE
                Text(
                  'Due date',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.buttonSecondary,
                          borderRadius: BorderRadius.circular(10),
                          border: _dateError
                              ? Border.all(color: Colors.redAccent)
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? DateFormat(
                                      'MMM d, yyyy',
                                    ).format(_selectedDate!)
                                  : 'Select a due date',
                              style: TextStyle(
                                color: _selectedDate != null
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.date_range_outlined,
                              size: 25,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_dateError)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          'Please select a due date',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                Spacer(),
                // CREATE TASK BUTTON
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryDark,
                            AppColors.primaryLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final formValid = _formKey.currentState!.validate();
                          setState(() {
                            _boardError = _selectedBoard == null;
                            _dateError = _selectedDate == null;
                            _titleError = context
                                .read<TitleCubit>()
                                .state
                                .title
                                .trim()
                                .isEmpty;
                          });
                          if (!formValid ||
                              _titleError ||
                              _boardError ||
                              _dateError)
                            return;
                          final task = TaskModel(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: context.read<TitleCubit>().state.title,
                            description: context
                                .read<DescriptionCubit>()
                                .state
                                .description,
                            boardId: _selectedBoard!.id,
                            priority: context.read<PriorityCubit>().state,
                            dueDate: _selectedDate!,
                          );
                          context.read<TasksCubit>().addTask(task);

                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          'Create Task',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
