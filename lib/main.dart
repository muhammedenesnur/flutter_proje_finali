import 'package:dev_template/feature/home/presantation/cubit/image_picker_cubit.dart';
import 'package:dev_template/feature/splash/cubit/splash_cubit.dart';
import 'package:dev_template/product/core/cache/cache_manager.dart';
import 'package:dev_template/product/core/constant/string_constant.dart';
import 'package:dev_template/product/core/initialize/project_initializer.dart';
import 'package:dev_template/product/utils/localization/localization_manager.dart';
import 'package:dev_template/product/utils/router/router_manager.dart';
import 'package:dev_template/product/utils/theme/cubit/theme_cubit.dart';
import 'package:dev_template/product/utils/theme/cubit/theme_state.dart';
import 'package:dev_template/product/utils/theme/dark/app_theme_dark.dart';
import 'package:dev_template/product/utils/theme/light/app_theme_light.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await ProjectInitializer.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<ImagePickerCubit>(
          create: (context) => ImagePickerCubit(
            ImageCacheManager(
              'image_cache_manager',
            ),
          )..initializeDatabase(),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
      ],
      child: LocalizationManager(
        child: const _MyApp(),
      ),
    ),
  );
}

/// This is the entry point of the application.
final class _MyApp extends StatelessWidget {
  /// This is the constructor of the class.
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: StringConstant.appName,

          /// This is the theme of the app
          theme: AppThemeLight().theme,
          darkTheme: AppThemeDark().theme,
          themeMode: state.themeMode,

          debugShowCheckedModeBanner: false,

          /// Localizations
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: RouterManager.routes,
        );
      },
    );
  }
}
