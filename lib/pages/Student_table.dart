import 'package:Quran/widgets/Bar/appBar.dart';
import 'package:flutter/material.dart';
import 'posts.dart';

var drawerlist = [
  {
    'page': 'الصفحة الرئيسية',
    'icon': Icon(Icons.home),
  },
  {'page': 'الامتحانات', 'icon': Icon(Icons.pending_actions_outlined)},
  {
    'page': 'العلامات',
    'icon': Icon(Icons.date_range),
  },
  {
    'page': 'جدول الحفظ',
    'icon': Icon(Icons.table_chart_outlined),
  },
  {
    'page': 'المنشورات',
    'icon': Icon(Icons.post_add),
  },
  {
    'page': 'البوم الصور',
    'icon': Icon(Icons.picture_in_picture),
  },
  {
    'page': 'تسجيل الخروج ',
    'icon': Icon(Icons.exit_to_app),
  }
];

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

class Table_student1 extends StatefulWidget {
  @override
  State<Table_student1> createState() => _Table_student1State();
}

class _Table_student1State extends State<Table_student1> {
  show() {
    visible = !visible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    double drawer_width = screen < 600 ? double.infinity : 300;
    return Scaffold(
      appBar: appbar(
        title: "جداول الحفظ",
        show: show,
        width: false,
      ),
      drawer: Drawer(
          width: drawer_width,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  onDetailsPressed: () {},
                  currentAccountPicture: ClipOval(
                    child: Image.asset("images/face.jpg"),
                  ),
                  accountName: Text("Mohammad"),
                  accountEmail: Text("Mohammad@hotmail.com")),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: drawerlist.length,
                  itemBuilder: (BuildContext context, i) {
                    return new ListTile(
                      title: new Text(
                        "${drawerlist[i]['page']}",
                      ),
                      trailing: drawerlist[i]['icon'],
                      onTap: () {
                        if (i == 4)
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return posts();
                          }));
                      },
                    );
                  }),
            ],
          )),
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
