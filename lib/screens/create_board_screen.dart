import 'package:flowly/core/app_colors.dart';
import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBoardScreen extends StatefulWidget {
  const CreateBoardScreen({super.key});

  @override
  State<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<CreateBoardScreen> {
  final TextEditingController _nameController = TextEditingController();
  IconData selectedIcon = Icons.dashboard_outlined;

  int selectedColorIndex = 0;

  final List<Color> boardColors = [
    Color(0xFF7C5CFC), // Purple
    Color(0xFF3B82F6), // Blue
    Color(0xFF22D3EE), // Cyan
    Color(0xFF22C55E), // Green
    Color(0xFFF59E0B), // Orange
    Color(0xFFF43F5E), // Coral
    const Color(0xFFA855F7),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

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
                          'Create New Board',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // ICON SELECTOR
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showIconPicker();
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFF20232D),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  selectedIcon,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Tap to choose icon',
                            style: TextStyle(
                              color: Color(0xFF969AA8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // BOARD NAME
                    const Text(
                      'Board name',
                      style: TextStyle(
                        color: Color(0xFFCFD1D7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 7),

                    TextField(
                      controller: _nameController,
                      cursorColor: const Color(0xFF7047EB),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'e.g. Mobile App',
                        hintStyle: const TextStyle(
                          color: Color(0xFF777B88),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF1D212C),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF7047EB),
                            width: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // COLOR TITLE
                    const Text(
                      'Choose color',
                      style: TextStyle(
                        color: Color(0xFFCFD1D7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // COLORS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(boardColors.length, (index) {
                        final color = boardColors[index];
                        final isSelected = selectedColorIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColorIndex = index;
                            });
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 27,
                                height: 27,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                          color: const Color(0xFFB4A5FF),
                                          width: 2,
                                        )
                                      : null,
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: color.withOpacity(.35),
                                            blurRadius: 8,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),

                              if (index != boardColors.length - 1)
                                Positioned(
                                  right: -1,
                                  top: -2,
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: _getDotColor(index),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // CREATE BOARD BUTTON
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
                    onPressed: () {
                      final boardName = _nameController.text.trim();
                      final selectedColor = boardColors[selectedColorIndex];

                      if (boardName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a board name'),
                          ),
                        );

                        return;
                      }

                      final board = Board(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),

                        name: boardName,
                        color: selectedColor,
                        icon: selectedIcon,
                      );

                      context.read<BoardsCubit>().addBoard(board);

                      Navigator.pop(context);
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
                      'Create Board',
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
    );
  }

  Color _getDotColor(int index) {
    final colors = [
      Color(0xFF7C5CFC), // Purple
      Color(0xFF3B82F6), // Blue
      Color(0xFF22D3EE), // Cyan
      Color(0xFF22C55E), // Green
      Color(0xFFF59E0B), // Orange
      Color(0xFFF43F5E), // Coral
      const Color(0xFFA855F7),
    ];

    if (index >= colors.length) {
      return Colors.transparent;
    }

    return colors[index];
  }

  void _showIconPicker() {
    final List<IconData> icons = [
      Icons.dashboard_outlined,
      Icons.code_rounded,
      Icons.phone_iphone_rounded,
      Icons.laptop_mac_rounded,
      Icons.design_services_outlined,
      Icons.brush_outlined,
      Icons.palette_outlined,
      Icons.work_outline_rounded,
      Icons.school_outlined,
      Icons.shopping_bag_outlined,
      Icons.attach_money_rounded,
      Icons.account_balance_wallet_outlined,
      Icons.fitness_center_rounded,
      Icons.sports_esports_outlined,
      Icons.music_note_rounded,
      Icons.camera_alt_outlined,
      Icons.flight_outlined,
      Icons.home_outlined,
      Icons.favorite_border_rounded,
      Icons.star_border_rounded,
      Icons.lightbulb_outline_rounded,
      Icons.rocket_launch_outlined,
      Icons.calendar_month_outlined,
      Icons.check_circle_outline_rounded,
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          decoration: const BoxDecoration(
            color: Color(0xFF181C26),
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Barrita superior
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3F4D),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose icon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final icon = icons[index];

                  final bool isSelected = selectedIcon == icon;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon;
                      });

                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF7047EB)
                            : const Color(0xFF222632),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFF9A82FF),
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Icon(
                        icon,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFFADB1BD),
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
