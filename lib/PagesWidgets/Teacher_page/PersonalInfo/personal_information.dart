import 'package:flutter/material.dart';

import '../../../pages/posts.dart';
import '../../../tableTitle.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import '../report/lecture/dropdown.dart';

class Personal_info extends StatefulWidget {
  Personal_info();

  @override
  State<Personal_info> createState() => _Personal_infoState();
}

class _Personal_infoState extends State<Personal_info> {
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
    List marride = ["متزوج", "غير متزوج"];
    List tagweed = [
      "أتقن التجويد وحصلت على شهادة",
      "أتقن التجويد وليس معي شهادة",
      "غير ذلك"
    ];
    List<String> co = ["  ", " "];
    List title = [
      tableTitle().titles('الاسم الرباعي'),
      tableTitle().titles('رقم الهوية'),
      tableTitle().titles(
        'البلد',
      ),
      tableTitle().titles('تاريخ الولادة'),
      tableTitle().titles('الحالة الجتماعية '),
      tableTitle().titles('العمل الحالي'),
      tableTitle().titles(' العمل السابق إن وجد'),
      tableTitle().titles(' المؤهل العلمي'),
      tableTitle().titles('الجامعة أو المعهد الذي تخرجت منه'),
      tableTitle().titles('أي شهادة أخرى'),
      tableTitle().titles('مستوى التجويد'),
      tableTitle().titles(' في حالة الحصول على شهادة تجويد في أي سنة :'),
      tableTitle().titles(' المسجد الذي تعلمت فيه التجويد:'),
      tableTitle().titles(' الشيخ الذي تعلمت على يديه :'),
      tableTitle().titles('العنوان'),
      tableTitle().titles('رقم الهاتف الشخصي'),
      tableTitle().titles('رقم الهاتف الأرضي'),
      tableTitle().titles('أي ملاحظات أخرى'),
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
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
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
      droplist(marride, "متزوج"),
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(),
      TextFormField(
        validator: (text) {
          if (text.isEmpty) {
            return req;
          }
          return null;
        },
      ),
      TextFormField(),
      TextFormField(),
      TextFormField(),
      droplist(tagweed, "أتقن التجويد وحصلت على شهادة"),
      TextFormField(
        keyboardType: TextInputType.number,
      ),
      TextFormField(),
      TextFormField(
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
        keyboardType: TextInputType.phone,
      ),
      TextFormField(),
      Text("")
    ];

    var celles = [];
    for (int i = 0; i < title.length; i++) {
      celles.add(title[i]);
      celles.add(contain[i]);
    }

    int numrowexa1 = 19;
    int numcol1 = 2;
    int numcel1 = 2;

    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawer(student: false, drawer_width: drawer().drawer_width),
      endDrawer: notification(
        width: screen,
        text: likeORcomment,
      ),
      appBar: AppBar(
        title: Text(
          "البيانات الشخصية ",
        ),
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
