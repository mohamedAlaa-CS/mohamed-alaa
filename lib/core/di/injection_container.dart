import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/portfolio/data/repositories/about_repository_impl.dart';
import '../../features/portfolio/data/repositories/profile_repository_impl.dart';
import '../../features/portfolio/domain/repositories/about_repository.dart';
import '../../features/portfolio/domain/repositories/profile_repository.dart';
import '../../features/portfolio/domain/use_cases/get_about_info_use_case.dart';
import '../../features/portfolio/domain/use_cases/get_profile_use_case.dart';
import '../../features/portfolio/presentation/cubit/about_cubit.dart';
import '../../features/portfolio/presentation/cubit/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ── External ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  // ── Data ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AboutRepository>(
    () => AboutRepositoryImpl(sl()),
  );

  // ── Domain ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetAboutInfoUseCase>(
    () => GetAboutInfoUseCase(sl()),
  );

  // ── Presentation ──────────────────────────────────────────────────────────
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(sl()),
  );
  sl.registerFactory<AboutCubit>(
    () => AboutCubit(sl()),
  );
}
