import 'package:flutter/material.dart';

import '../../../pages/posts.dart';
import '../../../tableTitle.dart';
import '../../Bar/drawer.dart';
import '../../Bar/notification.dart';
import 'examNavBottom.dart';

class ful_info extends StatelessWidget {
  ful_info();

  @override
  Widget build(BuildContext context) {
    List<String> co = ["الامتحان : ", "المؤمنون والفرقان  والمجادلة"];
    List title = [
      tableTitle().titles('الفوج'),
      tableTitle().titles('المركز'),
      tableTitle().titles(
        'اليوم',
      ),
      tableTitle().titles('التاريخ'),
      tableTitle().titles('علامة النجاح'),
      tableTitle().titles('علامة التجويد'),
      tableTitle().titles('مجموع العلامات'),
      tableTitle().titles('معدل المركز'),
      tableTitle().titles('التقدير'),
      tableTitle().titles('الأجزاء الممتحن بها'),
      tableTitle().titles('عدد الطلاب بعد الامتحان'),
      tableTitle().titles('لجنة الامتحان'),
      tableTitle().titles('الجوائز'),
      tableTitle().titles('ملاحظات'),
    ];

    List contain = [
      Text('18'),
      Text('بلاطة البلد'),
      Text('الثلاثاء'),
      Text('6/12/2022'),
      Text('70%'),
      Text('6%'),
      Text('2321.5'),
      Text('96.7%'),
      Text("ممتاز"),
      Text(
        'المجادلة والفرقان والشعراء',
        overflow: TextOverflow.fade,
      ),
      Text('رسميون(25)'),
      Text(
        " اللجنة , نضال عباس ,رمزي دويكات ,محمد ابو غضيب, قاسم القدح",
        overflow: TextOverflow.fade,
      ),
      Text(
        " عطر ,  بلوزة , مج ,  شامبو,  بشقير",
        overflow: TextOverflow.fade,
      ),
      Text(
        "  ",
        overflow: TextOverflow.fade,
      )
    ];

    var celles = [];
    for (int i = 0; i < title.length; i++) {
      celles.add(title[i]);
      celles.add(contain[i]);
    }

    int numrowexa1 = 13;
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
          "الامتحانات ",
        ),
      ),
      bottomNavigationBar: bottom_Nav_exam(),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  width: 600,
                  alignment: Alignment.center,
                  child: DataTable(
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
                      rows: tableTitle().rowexam(numrowexa1, numcel1, celles))),
            ],
          ),
        ),
      ),
    );
  }
}
