import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

@immutable

/// Initialize
final class ProjectInitializer {
  const ProjectInitializer._();

  /// Initialize
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    final directory = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(
      directory.path,
    );
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    await EasyLocalization.ensureInitialized();
  }
}
