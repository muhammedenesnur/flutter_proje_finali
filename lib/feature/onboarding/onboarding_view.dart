import 'package:dev_template/product/utils/localization/locale_keys.g.dart';
import 'package:dev_template/product/utils/router/route_paths.dart';
import 'package:dev_template/product/widget/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/images/img_onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).go(RoutePaths.home.path);
            },
            child: const Icon(Icons.arrow_forward),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const CustomText(
              text: LocaleKeys.onboarding_title,
            ),
          ),
        ),
      ],
    );
  }
}
