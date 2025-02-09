import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../bloc/product_details_bloc.dart';

class ProductMainImage extends StatelessWidget {
  const ProductMainImage({super.key, this.isLoading = false});
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 387.h,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: isLoading
          ? const Skeletonizer(
              child: CachedNetworkImageWidget(
                image: "",
              ),
            )
          : CachedNetworkImageWidget(
              image:
                  context.read<ProductDetailsBloc>().product.images.isNotEmpty
                      ? context.read<ProductDetailsBloc>().product.images.first
                      : "",
            ),
    );
  }
}
