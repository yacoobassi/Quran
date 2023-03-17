import 'package:flutter/material.dart';

class FiledIconButton extends StatefulWidget {
  Icon icon;
  Function swapicon;
  FiledIconButton({Key myKey, this.icon, this.swapicon}) : super(key: myKey);
  @override
  State<FiledIconButton> createState() => _FiledIconButtonState();
}

class _FiledIconButtonState extends State<FiledIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.icon,
      onPressed: () {
        widget.swapicon();
      },
    );
  }
}
