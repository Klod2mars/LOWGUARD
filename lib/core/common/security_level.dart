import 'package:flutter/material.dart';

enum SecurityLevel {
  clear(
    label: 'CLEAR',
    color: Color(0xFF39FF14), // Neon Green
    description: 'All systems nominal.',
  ),
  warning(
    label: 'WARNING',
    color: Color(0xFFFFCC00), // Amber
    description: 'Potential threat detected.',
  ),
  critical(
    label: 'CRITICAL',
    color: Color(0xFFFF3333), // Red
    description: 'High threat level. Action required.',
  ),
  breach(
    label: 'BREACH',
    color: Color(0xFFFF00FF), // Neon Magenta/Alert
    description: 'FORTEZZA BREACHED. Emergency protocols active.',
  );

  final String label;
  final Color color;
  final String description;

  const SecurityLevel({
    required this.label,
    required this.color,
    required this.description,
  });

  bool get isEmergency => this == SecurityLevel.breach;
}
