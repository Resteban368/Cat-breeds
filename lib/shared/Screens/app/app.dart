import 'package:cats_breeds/core/router/app_router.dart';
import 'package:cats_breeds/core/theme/app_theme.dart';
import 'package:cats_breeds/dependency_injection.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/blocs/breed_managemen/breed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<BreedCubit>())],
      child: MaterialApp.router(
        theme: AppTheme.appThemeData(),
        title: 'Cat breeds',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.appRouter,
      ),
    );
  }
}
