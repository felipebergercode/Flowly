import 'package:flowly/core/app_colors.dart';
import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

class PriorityContainers extends StatefulWidget {
  final void Function(TaskPriority)? onChanged;

  const PriorityContainers({super.key, this.onChanged});

  @override
  State<PriorityContainers> createState() => _PriorityContainersState();
}

class _PriorityContainersState extends State<PriorityContainers> {
  TaskPriority _selected = TaskPriority.medium;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _PriorityChip(
              label: 'Low',
              color: const Color(0xFF4CAF50),
              isSelected: _selected == TaskPriority.low,
              onTap: () {
                setState(() => _selected = TaskPriority.low);
                widget.onChanged?.call(TaskPriority.low);
              },
            ),
            const SizedBox(width: 10),
            _PriorityChip(
              label: 'Medium',
              color: const Color(0xFFFF9800),
              isSelected: _selected == TaskPriority.medium,
              onTap: () {
                setState(() => _selected = TaskPriority.medium);
                widget.onChanged?.call(TaskPriority.medium);
              },
            ),
            const SizedBox(width: 10),
            _PriorityChip(
              label: 'High',
              color: const Color(0xFFF44336),
              isSelected: _selected == TaskPriority.high,
              onTap: () {
                setState(() => _selected = TaskPriority.high);
                widget.onChanged?.call(TaskPriority.high);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityChip({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 45,
          decoration: BoxDecoration(
            color: isSelected
                ? color.withOpacity(0.2)
                : AppColors.buttonSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
