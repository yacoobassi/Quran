import 'package:flutter/material.dart';

class textFiled extends StatefulWidget {
  Icon icon;
  String text;
  bool password;
  textFiled({Key myKey, this.text, this.icon, this.password})
      : super(key: myKey);

  @override
  State<textFiled> createState() => _textFiledState();
}

class _textFiledState extends State<textFiled> {
  bool presed;
  Icon preicon, posticon;
  void initState() {
    super.initState();
    presed = false;
    preicon = widget.icon;
    posticon =
        widget.password ? Icon(Icons.remove_red_eye_rounded) : Icon(null);
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Form(
        child: TextFormField(
          obscureText: widget.password ? !presed : false,
          decoration: InputDecoration(
            hintText: "${widget.text}",
            prefixIcon: Icon(Icons.key),
            suffixIcon: IconButton(
              icon: posticon,
              onPressed: () {
                setState(() {
                  if (!presed)
                    posticon = Icon(Icons.remove_red_eye_rounded);
                  else
                    posticon = Icon(Icons.remove_red_eye_outlined);

                  presed = !presed;
                });
              },
            ),
            filled: true,
            fillColor: Colors.grey[280],
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300])),
          ),
        ),
      ),
    );
  }
}
