import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/app_assets.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({super.key, required this.image, this.fit});
  final String? image;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image ?? "",
      fit: fit,
      placeholder: (context, url) =>
          Skeletonizer(child: Image.asset(AppAssets.logo)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
