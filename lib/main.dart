import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/cubit/about_cubit.dart';
import 'features/portfolio/presentation/cubit/experience_cubit.dart';
import 'features/portfolio/presentation/cubit/profile_cubit.dart';
import 'features/portfolio/presentation/cubit/project_cubit.dart';
import 'features/portfolio/presentation/screens/portfolio_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ngmogrthiidailpwwwnm.supabase.co',
    anonKey: 'sb_publishable_WXCdvBXgxVd2J3J_DGIZpQ_OR3edHHi',
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (_) => di.sl<ProfileCubit>()..fetchProfile(),
        ),
        BlocProvider<AboutCubit>(
          create: (_) => di.sl<AboutCubit>()..fetchAboutInfo(),
        ),
        BlocProvider<ExperienceCubit>(
          create: (_) => di.sl<ExperienceCubit>()..fetchExperiences(),
        ),
        BlocProvider<ProjectCubit>(
          create: (_) => di.sl<ProjectCubit>()..fetchProjects(),
        ),
      ],
      child: MaterialApp(
        title: 'Mohamed Alaa - Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const PortfolioScreen(),
      ),
    );
  }
}

