import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class showImage extends StatelessWidget {
  showImage(this.image, this.url);
  String image;
  bool url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView(
        imageProvider:
            url ? CachedNetworkImageProvider(image) : FileImage(File(image)),
        minScale: PhotoViewComputedScale.contained * 0.5,
        maxScale: PhotoViewComputedScale.covered * 4,
      ),
    );
  }
}
