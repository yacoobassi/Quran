import 'package:Quran/widgets/Teacher_page/report/lecture/Lecture.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/dropdown.dart';
import 'package:Quran/widgets/Teacher_page/report/table/gettable.dart';
import 'package:flutter/material.dart';

class bottomInfo extends StatefulWidget {
  bottomInfo();

  @override
  State<bottomInfo> createState() => _bottomInfoState();
}

class _bottomInfoState extends State<bottomInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textfeildrow(
            TextField(
              textAlign: TextAlign.center,
              enabled: false,
              decoration: InputDecoration(labelText: "معدل المراجعة"),
            ),
            TextField(
              textAlign: TextAlign.center,
              enabled: false,
              decoration: InputDecoration(labelText: "معدل الحفظ"),
            ),
          ),
          textfeildrow(
              Text(
                " سلوك الطالب",
                style: TextStyle(fontSize: 20),
              ),
              droplist(Appreciation, "ممتاز")),
          textfeildrow(
              Text(" الصلاة في المسجد ", style: TextStyle(fontSize: 20)),
              droplist(Appreciation, " ")),
          textfeildrow(
            Text(" ملحوظات المدرس", style: TextStyle(fontSize: 20)),
            TextField(),
          ),
          textfeildrow(
            Text("  عدد أيام الغياب", style: TextStyle(fontSize: 20)),
            TextField(
              textAlign: TextAlign.center,
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}

class textfeildrow extends StatefulWidget {
  textfeildrow(this.field, this.title);
  Widget field;
  Widget title;

  @override
  State<textfeildrow> createState() => _textfeildrowState();
}

class _textfeildrowState extends State<textfeildrow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(width: 5)),
          alignment: Alignment.center,
          width: 400,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5),
                child: widget.field,
                height: 50,
                width: 194,
                decoration: BoxDecoration(border: Border.all()),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 5),
                child: widget.title,
                height: 50,
                width: 196,
                decoration: BoxDecoration(border: Border.all()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
