import 'package:dev_template/product/core/model/shoe.dart';
import 'package:equatable/equatable.dart';

enum ShoesStatus { initial, loading, success, failure }

final class ShoesState extends Equatable {
  const ShoesState({
    this.status = ShoesStatus.initial,
    this.shoes = const <Shoe>[],
    this.error,
  });

  final ShoesStatus status;
  final List<Shoe> shoes;
  final String? error;

  ShoesState copyWith({
    ShoesStatus? status,
    List<Shoe>? shoes,
    String? error,
  }) {
    return ShoesState(
      status: status ?? this.status,
      shoes: shoes ?? this.shoes,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, shoes, error];
}
