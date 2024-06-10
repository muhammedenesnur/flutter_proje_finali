import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

@JsonSerializable()
class Rating with EquatableMixin {
  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  @JsonKey(name: 'rate')
  double? rate;
  @JsonKey(name: 'count')
  int? count;

  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  List<Object?> get props => [rate, count];

  Rating copyWith({
    double? rate,
    int? count,
  }) {
    return Rating(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }
}
