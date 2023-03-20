import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class showImage extends StatelessWidget {
  showImage(this.image, this.url);
  String image;
  bool url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 4,
        child: Container(
          width: double.infinity,
          child: url
              ? ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: double.infinity,
                  ),
                )
              : Image.file(
                  File(image),
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
