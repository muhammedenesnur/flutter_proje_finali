import 'package:hive/hive.dart';

part 'is_sign.g.dart';

@HiveType(typeId: 1)
final class IsSign {
  const IsSign({
    required this.isSign,
  });

  factory IsSign.fromJson(Map<String, dynamic> json) {
    return IsSign(
      isSign: json['isSign'] as bool,
    );
  }

  @HiveField(0)
  final bool isSign;

  Map<String, dynamic> toJson() {
    return {
      'isSign': isSign,
    };
  }

  IsSign copyWith({
    bool? isSign,
  }) {
    return IsSign(
      isSign: isSign ?? this.isSign,
    );
  }
}
