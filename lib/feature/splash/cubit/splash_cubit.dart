import 'package:dev_template/feature/splash/cubit/splash_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SplashCubit extends HydratedCubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  void markSplashSeen() {
    emit(state.copyWith(hasSeenSplash: true));
  }

  @override
  SplashState fromJson(Map<String, dynamic> json) {
    return SplashState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(SplashState state) {
    return state.toMap();
  }
}
