import 'package:flutter/material.dart';

class Board {
  final String name;
  final Color color;
  final IconData icon;
  final String id;

  const Board({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}
