import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/app_images.dart';
import 'package:ecommerce/models/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ImageProductDetail extends StatelessWidget {
  const ImageProductDetail(
      {Key? key, required this.productEntity, required this.controller})
      : super(key: key);
  final ProductEntity productEntity;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: productEntity.images.length,
      scrollDirection: Axis.horizontal,
      controller: controller,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: productEntity.images[index],
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Image.network(AppImages.imageDefault),
        );
      },
    );
  }
}