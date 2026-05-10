import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_about_info_use_case.dart';
import 'about_state.dart';

/// Fetches and exposes the About Me section data.
class AboutCubit extends Cubit<AboutState> {
  AboutCubit(this._getAboutInfo) : super(const AboutInitial());

  final GetAboutInfoUseCase _getAboutInfo;

  Future<void> fetchAboutInfo() async {
    emit(const AboutLoading());
    try {
      final aboutInfo = await _getAboutInfo();
      emit(AboutLoaded(aboutInfo));
    } catch (e) {
      emit(AboutError(e.toString()));
    }
  }
}
