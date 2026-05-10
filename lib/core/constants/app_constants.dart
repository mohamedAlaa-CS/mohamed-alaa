import 'package:flutter/material.dart';

/// All static portfolio content lives here – no hardcoded strings in widgets.
abstract final class AppConstants {
  // ── Personal Info ──────────────────────────────────────────────
  static const String name = 'Mohamed Alaa';
  static const String role = 'Flutter Developer';
  static const String bio =
      'Flutter developer with 1+ year experience building scalable mobile '
      'applications using clean architecture, Cubit, Firebase, APIs, offline '
      'support, payment systems, and real-time features.';
  static const String email = 'mohamedAlaa@gmail.com';
  static const String githubUrl = 'https://github.com/mohamedAlaa-CS';
  static const String linkedinUrl = 'https://linkedin.com/in/mohamedAlaa';

  // ── Navigation ─────────────────────────────────────────────────
  static const List<String> navItems = [
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  // ── About Stats ────────────────────────────────────────────────
  static const List<({String value, String label, IconData icon})> stats = [
    (value: '10+', label: 'Projects', icon: Icons.folder_outlined),
    (value: '1+', label: 'Years Exp', icon: Icons.timeline_outlined),
    (value: '15+', label: 'Technologies', icon: Icons.code_outlined),
    (value: '5+', label: 'Clients', icon: Icons.people_outlined),
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

  // ── Experience ─────────────────────────────────────────────────
  static const List<ExperienceData> experiences = [
    ExperienceData(
      role: 'Flutter Developer',
      company: 'Freelance',
      period: '2024 – Present',
      description:
          'Building production-grade Flutter apps for clients. Implementing '
          'clean architecture, state management with Cubit/BLoC, Firebase '
          'integration, REST APIs, and payment systems.',
      highlights: [
        'Delivered 10+ mobile applications',
        'Implemented Stripe & Paymob payment systems',
        'Built real-time features with Pusher',
      ],
    ),
    ExperienceData(
      role: 'Mobile App Developer',
      company: 'Self-Employed',
      period: '2023 – 2024',
      description:
          'Developed personal projects and contributed to open-source Flutter '
          'packages. Focused on learning advanced architecture patterns and '
          'performance optimization.',
      highlights: [
        'Mastered Clean Architecture patterns',
        'Built offline-first applications',
        'Integrated Firebase Auth, Firestore, and FCM',
      ],
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

/// Data model for a timeline experience entry.
class ExperienceData {
  const ExperienceData({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.highlights,
  });

  final String role;
  final String company;
  final String period;
  final String description;
  final List<String> highlights;
}
