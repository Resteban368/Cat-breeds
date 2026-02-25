import 'package:cats_breeds/core/helpers/debounce.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/blocs/breed_managemen/breed_cubit.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildSearchAppBarWidget extends StatefulWidget {
  const BuildSearchAppBarWidget({super.key});

  @override
  State<BuildSearchAppBarWidget> createState() =>
      _BuildSearchAppBarWidgetState();
}

class _BuildSearchAppBarWidgetState extends State<BuildSearchAppBarWidget> {
  final debounce = Debouncer(milliseconds: 1000);
  late final TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      controller: controller,
      hidenText: 'Search Cat Breeds',
      onPressedIcon: () {
        controller?.clear();
        context.read<BreedCubit>().onRefresh();
      },
      onChanged: (value) {
        debounce.run(() => context.read<BreedCubit>().getBreedByName(value));
      },
    );
  }
}
