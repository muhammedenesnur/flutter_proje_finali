import 'package:dev_template/product/core/model/image_model.dart';
import 'package:equatable/equatable.dart';

enum ImagePickerStatus { initial, loading, success, error }

final class ImagePickerState extends Equatable {
  const ImagePickerState({
    this.status = ImagePickerStatus.initial,
    this.imagePath,
    this.error,
  });
  final ImagePickerStatus status;
  final ImageModel? imagePath;
  final String? error;

  ImagePickerState copyWith({
    ImagePickerStatus? status,
    ImageModel? imagePath,
    String? error,
  }) {
    return ImagePickerState(
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, imagePath, error];
}
