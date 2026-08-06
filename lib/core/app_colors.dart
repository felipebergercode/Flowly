import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // -------------------------------------------------
  // PRIMARY
  // -------------------------------------------------

  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF5A50F2);
  static const Color primaryLight = Color(0xFF8B84FF);

  // -------------------------------------------------
  // BACKGROUND
  // -------------------------------------------------

  static const Color background = Color(0xFF03030B);
  static const Color scaffold = Color(0xFF0E1117);

  // -------------------------------------------------
  // SURFACES
  // -------------------------------------------------

  static const Color surface = Color(0xFF171B23);
  static const Color card = Color(0xFF1D222D);
  static const Color elevated = Color(0xFF242A36);

  // -------------------------------------------------
  // BORDERS
  // -------------------------------------------------

  static const Color border = Color(0xFF2A3040);
  static const Color divider = Color(0xFF30384A);

  // -------------------------------------------------
  // TEXT
  // -------------------------------------------------

  static const Color textPrimary = Color(0xFFF7F8FA);
  static const Color textSecondary = Color(0xFFB2BAC8);
  static const Color textTertiary = Color(0xFF7D8798);

  // -------------------------------------------------
  // STATUS
  // -------------------------------------------------

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // -------------------------------------------------
  // PRIORITIES
  // -------------------------------------------------

  static const Color priorityLow = Color(0xFF22C55E);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityHigh = Color(0xFFEF4444);

  // -------------------------------------------------
  // LABELS
  // -------------------------------------------------

  static const Color labelPurple = Color(0xFF8B5CF6);
  static const Color labelBlue = Color(0xFF3B82F6);
  static const Color labelGreen = Color(0xFF22C55E);
  static const Color labelOrange = Color(0xFFF97316);
  static const Color labelPink = Color(0xFFEC4899);

  // -------------------------------------------------
  // KANBAN COLUMN COLORS
  // -------------------------------------------------

  static const Color todo = Color(0xFF6366F1);
  static const Color inProgress = Color(0xFF3B82F6);
  static const Color review = Color(0xFFF59E0B);
  static const Color done = Color(0xFF22C55E);

  // -------------------------------------------------
  // ICONS
  // -------------------------------------------------

  static const Color iconPrimary = textPrimary;
  static const Color iconSecondary = textSecondary;
  static const Color iconDisabled = textTertiary;

  // -------------------------------------------------
  // INPUTS
  // -------------------------------------------------

  static const Color inputFill = Color(0xFF171B23);
  static const Color inputBorder = Color(0xFF2A3040);
  static const Color inputFocused = primary;

  // -------------------------------------------------
  // BUTTONS
  // -------------------------------------------------

  static const Color buttonPrimary = primary;
  static const Color buttonPrimaryPressed = primaryDark;

  static const Color buttonSecondary = Color(0xFF232936);

  // -------------------------------------------------
  // SHADOWS
  // -------------------------------------------------

  static const Color shadow = Color(0x33000000);

  // -------------------------------------------------
  // OVERLAYS
  // -------------------------------------------------

  static const Color overlay = Color(0x99000000);

  // -------------------------------------------------
  // TRANSPARENT
  // -------------------------------------------------

  static const Color transparent = Colors.transparent;
}
