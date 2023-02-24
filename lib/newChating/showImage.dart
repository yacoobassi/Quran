import 'dart:io';

import 'package:flutter/material.dart';

class showImage extends StatelessWidget {
  showImage({Key key, this.image}) : super(key: key);
  String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: Image.file(
          File(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
