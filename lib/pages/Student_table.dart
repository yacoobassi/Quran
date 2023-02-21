import 'package:Quran/widgets/Bar/appBar.dart';
import 'package:flutter/material.dart';
import '../widgets/Bar/notification.dart';
import 'posts.dart';

final columns = [
  "اليوم",
  "التاريخ",
  "موضع الحفظ",
  "العلامة",
  "موضع المراجعة",
  "العلامة",
  "الحضور",
  "تمت المشاهدة"
];

final rows = [
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view"),
  data("day", "date", "study", "mark1", "repeat", "mark2", "exist", "view")
];

class data {
  String day, date, study, mark1, repeat, mark2, exist, view;

  data(day, date, study, mark1, repeat, mark2, exist, view) {
    this.day = day;
    this.date = date;
    this.study = study;
    this.mark1 = mark1;
    this.repeat = repeat;
    this.mark2 = mark2;
    this.exist = exist;
    this.view = view;
  }
}

bool visible;

class Table_student1 extends StatefulWidget {
  @override
  State<Table_student1> createState() => _Table_student1State();
}

class _Table_student1State extends State<Table_student1> {
  GlobalKey<ScaffoldState> globalkey = new GlobalKey<ScaffoldState>();
  show(String text) {
    globalkey.currentState.openEndDrawer();
    likeORcomment = text;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = false;
  }

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    bool infinity;
    if (screen < 600)
      infinity = true;
    else
      infinity = false;
    return Scaffold(
      key: globalkey,
      appBar: appbar(
        title: "جداول الحفظ",
        show: show,
        width: false,
        opacity: 1,
      ),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15),
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الجزء: جزء تبارك",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "العام: 2023",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "المجموعة :الاولى",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DataTable(
                columns: getcolumns(columns),
                rows: getrows(rows),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

List<DataColumn> getcolumns(List<String> columns) =>
    columns.map((String column) => DataColumn(label: Text(column))).toList();

List<DataRow> getrows(List<data> rows) => rows.map((data cell) {
      final cells = [
        cell.day,
        cell.date,
        cell.study,
        cell.mark1,
        cell.repeat,
        cell.mark2,
        cell.exist,
        cell.view
      ];
      return DataRow(cells: getcells(cells));
    }).toList();
List<DataCell> getcells(List<String> cells) =>
    cells.map((data) => DataCell(Text('$data'))).toList();
