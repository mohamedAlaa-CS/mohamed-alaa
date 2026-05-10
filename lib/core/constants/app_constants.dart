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

  // ── Projects ───────────────────────────────────────────────────
  static const List<ProjectData> projects = [
    ProjectData(
      title: 'Quran Khatma App',
      description:
          'A collaborative Quran reading app that allows users to create and '
          'join khatmas, track progress, and compete in leaderboards. Built '
          'with real-time sync and offline support.',
      tags: ['Flutter', 'Firebase', 'Cubit', 'Offline'],
      githubUrl: 'https://github.com/mohamedAlaa-CS',
      color: Color(0xFF6C63FF),
    ),
    ProjectData(
      title: 'Hotel Booking App',
      description:
          'A full-featured hotel booking app with room browsing, filtering, '
          'booking management, payment integration via Stripe, and push '
          'notifications for booking updates.',
      tags: ['Flutter', 'REST API', 'Stripe', 'Clean Arch'],
      githubUrl: 'https://github.com/mohamedAlaa-CS',
      color: Color(0xFF00D9FF),
    ),
    ProjectData(
      title: 'Real-time Chat App',
      description:
          'A messaging application with real-time chat using Pusher, media '
          'sharing, typing indicators, read receipts, and group conversation '
          'support.',
      tags: ['Flutter', 'Pusher', 'Real-time', 'Firebase'],
      githubUrl: 'https://github.com/mohamedAlaa-CS',
      color: Color(0xFFDB761F),
    ),
    ProjectData(
      title: 'E-Learning Platform',
      description:
          'An educational platform with video courses, quizzes, progress '
          'tracking, certificate generation, and payment integration using '
          'Paymob.',
      tags: ['Flutter', 'Paymob', 'Video', 'Cubit'],
      githubUrl: 'https://github.com/mohamedAlaa-CS',
      color: Color(0xFFFFB785),
    ),
  ];

  // ── Layout ─────────────────────────────────────────────────────
  static const double maxContentWidth = 1200;
  static const double sectionSpacing = 80;
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}

/// Data model for a featured project.
class ProjectData {
  const ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.color,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
  final Color color;
}

