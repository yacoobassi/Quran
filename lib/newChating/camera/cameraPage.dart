import 'package:flutter/material.dart';

import 'camera_scareen.dart';

class CameraPage extends StatelessWidget {
  Function scroll, refresh;
  CameraPage({Key key, this.scroll, this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen(scroll: scroll, refresh: refresh);
  }
}
