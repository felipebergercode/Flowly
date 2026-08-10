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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.toARGB32(),
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
    };
  }

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'],
      name: json['name'],
      color: Color(json['color']),
      icon: IconData(json['iconCodePoint'], fontFamily: json['iconFontFamily']),
    );
  }
}
