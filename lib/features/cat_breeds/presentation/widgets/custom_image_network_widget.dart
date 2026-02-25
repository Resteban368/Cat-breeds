import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'custom_gif_widget.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  const CustomNetworkImageWidget({
    super.key,
    required this.url,
    this.borderRadius = BorderRadius.zero,
  });

  final String url;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius!,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        progressIndicatorBuilder: (context, url, progress) => CustomGifWidget(
          gifName: 'loading',
        ),
        errorWidget: (context, url, error) => CustomGifWidget(
          gifName: 'error',
        ),
      ),
    );
  }
}
