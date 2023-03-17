import 'package:flutter/material.dart';

class title extends StatelessWidget {
  title(this.t,this.w);
  String t;
  double w;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: w,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.green),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        t,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
