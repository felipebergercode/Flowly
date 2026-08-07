import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flowly/widgets/priority_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

enum TaskPriority { low, medium, high }

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Board? _selectedBoard;
  DateTime? _selectedDate;

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
                  setState(() => _selectedBoard = b);
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
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: AppColors.buttonSecondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'eg. Fix Ul bugs',
                          ),
                        ),
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
                  return GestureDetector(
                    onTap: () => _pickBoard(state.boards),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.buttonSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedBoard?.name ?? 'Choose any of your board',
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
                  );
                },
              ),
              SizedBox(height: 20),
              //PRIORITY CHOOSE
              PriorityContainers(),
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
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buttonSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate != null
                            ? DateFormat('MMM d, yyyy').format(_selectedDate!)
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
                        colors: [AppColors.primaryDark, AppColors.primaryLight],
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
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
    );
  }
}
