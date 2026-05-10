import 'package:flutter/material.dart';

/// Static portfolio content — layout, nav, skills, projects, experience.
/// Personal-info fields (name, role, bio, email, links) are fetched dynamically
/// from Supabase via [ProfileCubit].
abstract final class AppConstants {

  // ── Navigation ─────────────────────────────────────────────────
  static const List<String> navItems = [
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  // ── Skills ─────────────────────────────────────────────────────
  static const List<({String name, IconData icon, double level})> skills = [
    (name: 'Flutter', icon: Icons.flutter_dash, level: 0.9),
    (name: 'Dart', icon: Icons.code, level: 0.85),
    (name: 'Firebase', icon: Icons.local_fire_department_outlined, level: 0.8),
    (name: 'REST API', icon: Icons.api_outlined, level: 0.85),
    (name: 'Git & GitHub', icon: Icons.merge_type_outlined, level: 0.8),
    (name: 'Clean Architecture', icon: Icons.architecture_outlined, level: 0.85),
    (name: 'State Management', icon: Icons.account_tree_outlined, level: 0.85),
    (name: 'SQLite & Hive', icon: Icons.storage_outlined, level: 0.75),
    (name: 'UI/UX Design', icon: Icons.design_services_outlined, level: 0.7),
    (name: 'Responsive Design', icon: Icons.devices_outlined, level: 0.8),
    (name: 'Notifications', icon: Icons.notifications_outlined, level: 0.75),
    (name: 'Payments', icon: Icons.payment_outlined, level: 0.7),
  ];

  // ── Layout ─────────────────────────────────────────────────────
  static const double maxContentWidth = 1200;
  static const double sectionSpacing = 80;
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}

