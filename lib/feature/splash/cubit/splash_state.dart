import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({required this.hasSeenSplash});

  factory SplashState.initial() {
    return const SplashState(hasSeenSplash: false);
  }

  factory SplashState.fromMap(Map<String, dynamic> map) {
    return SplashState(
      hasSeenSplash: map['hasSeenSplash'] as bool,
    );
  }
  final bool hasSeenSplash;

  @override
  List<Object> get props => [hasSeenSplash];

  SplashState copyWith({bool? hasSeenSplash}) {
    return SplashState(
      hasSeenSplash: hasSeenSplash ?? this.hasSeenSplash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hasSeenSplash': hasSeenSplash,
    };
  }
}
