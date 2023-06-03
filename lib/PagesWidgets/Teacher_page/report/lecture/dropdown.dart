import 'package:flutter/material.dart';

class droplist extends StatefulWidget {
  droplist(this.droplist1, this.selected1, this.Functon);
  Function Functon;
  List droplist1;
  String selected1;

  @override
  State<droplist> createState() => _droplistState();
}

class _droplistState extends State<droplist> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: widget.droplist1
          .map((e) => DropdownMenuItem(
                child: Text("$e"),
                value: e,
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          widget.selected1 = val;
        });
        widget.Functon(val);
      },
      value: widget.selected1,
    );
  }
}
