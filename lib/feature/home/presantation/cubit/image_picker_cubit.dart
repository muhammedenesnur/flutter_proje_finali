import 'dart:io';

import 'package:dev_template/feature/home/presantation/cubit/image_picker_state.dart';
import 'package:dev_template/product/core/cache/cache_manager.dart';
import 'package:dev_template/product/core/model/image_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

final class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(this._cacheManager) : super(const ImagePickerState());

  final _imagePicker = ImagePicker();
  final ICacheManager<ImageModel> _cacheManager;

  Future<void> initializeDatabase() async {
    await _cacheManager.init();
    final images = _cacheManager.getValues();
    if (images.isNotEmpty) {
      emit(
        state.copyWith(
          imagePath: images.last,
          status: ImagePickerStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: ImagePickerStatus.initial));
    }
  }

  Future<void> pickImage() async {
    emit(state.copyWith(status: ImagePickerStatus.loading));
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      emit(state.copyWith(status: ImagePickerStatus.error));
      return;
    }

    try {
      final applicationPath = await getApplicationDocumentsDirectory();
      final fileName = 'image1${path.extension(pickedFile.path)}';
      final savedImagePath = path.join(applicationPath.path, fileName);

      print('Picked file path: ${pickedFile.path}');
      print('Saving image to: $savedImagePath');

      final pickedFileExists = await File(pickedFile.path).exists();
      print('Picked file exists: $pickedFileExists');

      if (!pickedFileExists) {
        throw Exception('Picked file does not exist');
      }

      // Ensure the cache directory exists
      final cacheDir = Directory(applicationPath.path);
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }

      // Delete the old image if it exists
      final oldImage = File(savedImagePath);
      if (await oldImage.exists()) {
        await oldImage.delete();
        await _cacheManager.removeItem(state.imagePath!.id);
        print('Old image deleted: $savedImagePath');
      }

      // Copy the new file and ensure it exists at the new location
      final savedImage = await File(pickedFile.path).copy(savedImagePath);
      final savedImageExists = await savedImage.exists();
      print('Saved image exists: $savedImageExists');

      if (!savedImageExists) {
        throw Exception('Failed to save the image');
      }

      final imageModel = ImageModel(path: savedImage.path);
      await _cacheManager.putItem(imageModel.id, imageModel);

      emit(
        state.copyWith(
          status: ImagePickerStatus.success,
          imagePath: imageModel,
        ),
      );
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(status: ImagePickerStatus.error, error: e.toString()),
      );
    }
  }
}
