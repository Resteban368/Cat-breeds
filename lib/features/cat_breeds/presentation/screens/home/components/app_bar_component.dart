import 'package:cats_breeds/features/cat_breeds/presentation/screens/home/widgets/custom_search_app_bar_widget.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      preferredSizeValue: 52,
      title: BuildTitleAppBarWidget(title: 'Cat Breeds'),
      bottom: BuildSearchAppBarWidget(),
    );
  }
}
