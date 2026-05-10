import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/screens/portfolio_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohamed Alaa - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioScreen(),
    );
  }
}
