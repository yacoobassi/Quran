import 'package:Quran/tableTitle.dart';
import 'package:Quran/widgets/Teacher_page/report/lecture/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:Quran/tableTitle.dart';

import '../../pages/posts.dart';
import '../Bar/drawer.dart';
import '../Bar/notification.dart';

class Personal_student extends StatefulWidget {
  Personal_student();

  @override
  State<Personal_student> createState() => _Personal_studentState();
}

class _Personal_studentState extends State<Personal_student> {
  DateTime date = DateTime.now();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  String req = "يجب ملأ هذه الخانة";
  void _showDatePikcer() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        date = value;
      });
    });
  }

  send() {
    var formdata = formstate.currentState;
    if (formdata.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    List alsaf = [
      "أصغر من أول",
      "أول",
      "الثاني",
      "الثالث",
      "الرابع",
      "الخامس",
      "السادس",
      "السابع",
      "الثامن",
      "التاسع",
      "أكبر من التاسع"
    ];
    List Appreciation = [
      " ",
      "ممتاز",
      "جيد جدا",
      "جيد",
      "مقبول",
      "ضعيف",
    ];

    List<String> co = ["  ", " "];
    List title = [
      tableTitle().titles('رقم الطالب '),
      tableTitle().titles('الاسم الرباعي'),
      tableTitle().titles('رقم الهوية'),
      tableTitle().titles(
        'الصف',
      ),
      tableTitle().titles('المستوى الدراسي'),
      tableTitle().titles('تاريخ الولادة'),
      tableTitle().titles('رقم جوال الأب'),
      tableTitle().titles('رقم جوال الأم'),
      tableTitle().titles('الفوج'),
      tableTitle().titles('المركز'),
      tableTitle().titles('المدرسة'),
      MaterialButton(
        onPressed: send,
        child: Text(
          "تخزين",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: Colors.green,
      )
    ];

    List contain = [
      TextFormField(
        enabled: false,
        keyboardType: TextInputType.number,
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(
        keyboardType: TextInputType.name,
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      droplist(alsaf, "أول"),
      droplist(Appreciation, "ممتاز"),
      MaterialButton(
        color: Colors.green,
        onPressed: _showDatePikcer,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "${date.year}/${date.month}/${date.day}",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
        enabled: false,
      ),
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
        enabled: false,
      ),
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      Text("")
    ];

    var celles = [];
    for (int i = 0; i < title.length; i++) {
      celles.add(title[i]);
      celles.add(contain[i]);
    }

    int numrowexa1 = 12;
    int numcol1 = 2;
    int numcel1 = 2;

     final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("البيانات الشخصية"),),

       drawer: drawer(
          student: true,
          email: "Yacoobassi8@gmai.com",
          name: "Yacoob assi",
          image: "images/face.jpg",
          drawer_width: drawer().drawer_width),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  DataTable(
                    dataRowHeight: 70,
                    dataTextStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    border: TableBorder(
                      bottom: BorderSide(color: Colors.green),
                      top: BorderSide(color: Colors.green),
                      horizontalInside: BorderSide(
                          color: Colors.green, style: BorderStyle.solid),
                    ),
                    columns: tableTitle().col(numcol1, co),
                    rows: tableTitle().rowexam(numrowexa1, numcel1, celles),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
