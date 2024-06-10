import 'dart:io';

import 'package:dev_template/feature/home/presantation/cubit/image_picker_cubit.dart';
import 'package:dev_template/feature/home/presantation/cubit/image_picker_state.dart';
import 'package:dev_template/feature/splash/cubit/splash_cubit.dart';
import 'package:dev_template/product/utils/localization/locale_keys.g.dart';
import 'package:dev_template/product/utils/localization/localization_manager.dart';
import 'package:dev_template/product/utils/theme/cubit/theme_cubit.dart';
import 'package:dev_template/product/widget/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    markSplashSeen();
  }

  Future<void> markSplashSeen() async {
    context.read<SplashCubit>().markSplashSeen();
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeBody();
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale == Locales.tr.locale) {
                LocalizationManager.updateLanguage(
                  context: context,
                  value: Locales.en,
                );
              } else {
                LocalizationManager.updateLanguage(
                  context: context,
                  value: Locales.tr,
                );
              }
            },
            icon: const Icon(
              Icons.language,
            ),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<ThemeCubit>()
                  .changeTheme(brightness: Theme.of(context).brightness);
            },
            icon: Icon(
              context.read<ThemeCubit>().state.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ImagePickerCubit, ImagePickerState>(
              builder: (context, state) {
                switch (state.status) {
                  case ImagePickerStatus.initial:
                    return IconButton(
                      icon: const Icon(
                        Icons.image,
                      ),
                      onPressed: () {},
                    );
                  case ImagePickerStatus.loading:
                    return const CircularProgressIndicator();
                  case ImagePickerStatus.success:
                    return Image.file(
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                        );
                      },
                      File(
                        state.imagePath?.path ?? '',
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.cover,
                    );
                  case ImagePickerStatus.error:
                    return Text(state.error ?? '');
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ImagePickerCubit>().pickImage();
              },
              child: const CustomText(
                text: LocaleKeys.home_pick_image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
