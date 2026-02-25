import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    this.hidenText,
    this.onPressedIcon,
    this.onChanged,
    this.borderRadius,
  });

  final String? hidenText;
  final Function()? onPressedIcon;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final BorderRadiusGeometry? borderRadius;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  double _iconScale = 0.0;
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _iconScale = widget.controller!.text.isNotEmpty ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: widget.borderRadius),
      child: TextField(
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hidenText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          suffixIcon: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: _iconScale),
            duration: const Duration(milliseconds: 500),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    widget.controller?.clear();
                    widget.onPressedIcon?.call();
                  },
                ),
              );
            },
          ),
          prefixIcon: const Icon(Icons.pets_rounded),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
