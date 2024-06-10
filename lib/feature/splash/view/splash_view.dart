import 'dart:convert';

import 'package:dev_template/feature/splash/cubit/splash_cubit.dart';
import 'package:dev_template/product/core/model/splash_data.dart';
import 'package:dev_template/product/utils/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  late Future<SplashData> splashData;

  Future<SplashData> fetchSplashData() async {
    final response = await rootBundle.loadString('assets/splash/splash.json');
    final data = await json.decode(response);
    return SplashData.fromJson(data as Map<String, dynamic>);
  }

  @override
  void initState() {
    super.initState();
    splashData = fetchSplashData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<SplashData>(
        future: splashData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Lottie.asset(
                snapshot.data?.image ?? '',
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
                frameRate: FrameRate.max,
                onLoaded: (composition) {
                  Future.delayed(const Duration(seconds: 5), () {
                    if (context.read<SplashCubit>().state.hasSeenSplash) {
                      GoRouter.of(context).go(RoutePaths.home.path);
                    } else {
                      GoRouter.of(context).go(RoutePaths.onboarding.path);
                    }
                  });
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading splash data'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
