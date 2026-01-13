import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;

  const ImageCard({super.key, required this.imageUrl, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, imageUrl) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, imageUrl, error) => Center(child: Icon(Icons.error)),
      ),
    );
  }
}