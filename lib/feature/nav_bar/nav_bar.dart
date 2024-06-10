import 'package:dev_template/product/utils/localization/locale_keys.g.dart';
import 'package:dev_template/product/utils/router/route_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class NavBarView extends StatelessWidget {
  const NavBarView({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go(RoutePaths.home.path);
            case 1:
              GoRouter.of(context).go(RoutePaths.shoes.path);
            case 2:
              GoRouter.of(context).go(RoutePaths.post.path);
          }
        },
        selectedItemColor: Theme.of(context).primaryColor, // Seçili olan renk
        unselectedItemColor:
            Theme.of(context).disabledColor, // Seçili olmayan renk
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            label: LocaleKeys.home_title.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.directions_walk,
            ),
            label: LocaleKeys.shoes_title.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.post_add,
            ),
            label: LocaleKeys.post_title.tr(),
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final goRouter = GoRouter.of(context);
    final location = goRouter.routerDelegate.currentConfiguration.fullPath;
    if (location == RoutePaths.home.path) {
      return 0;
    } else if (location == RoutePaths.shoes.path) {
      return 1;
    } else if (location == RoutePaths.post.path) {
      return 2;
    } else {
      return 0;
    }
  }
}
