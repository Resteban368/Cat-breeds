import 'package:cats_breeds/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.preferredSizeValue,
    required this.title,
    required this.bottom,
    this.fixed = false,
    this.actions,
  });

  final double preferredSizeValue;
  final BuildTitleAppBarWidget title;
  final Widget bottom;
  final bool? fixed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      actions: actions,
      pinned: true,
      floating: !fixed!,
      snap: !fixed!,
      centerTitle: true,
      title: title,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(preferredSizeValue),
        child: bottom,
      ),
    );
  }
}

class BuildTitleAppBarWidget extends StatelessWidget {
  const BuildTitleAppBarWidget({
    super.key,
    required this.title,
    this.iconPath = 'assets/images/cat.png',
  });

  final String title;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.white,
            image: DecorationImage(
              image: AssetImage(iconPath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(title),
      ],
    );
  }
}
