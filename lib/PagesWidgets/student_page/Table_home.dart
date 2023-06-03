import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../../pages/Student_table.dart';
import '../Bar/appBar.dart';

List titles = [
  "اليوم",
  "التاريخ",
  "موضع الحفظ",
  "العلامة",
  "موضع المراجعة",
  "العلامة",
  "الحضور",
  "تمت المشاهدة"
];

class Table_student1 extends StatefulWidget {
  @override
  State<Table_student1> createState() => _Table_student1State();
}

class _Table_student1State extends State<Table_student1> {
  show() {
    visible = !visible;
    setState(() {});
  }

  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        title: " جدول الحفظ",
        show: show,
      ),
      drawer: Drawer(),
      body: Column(children: [
        Container(
          height: 500,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(style: BorderStyle.solid)),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "جدول الحفظ والعلامات ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                        child: Text(
                      " الجزء: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    )),
                    Text(
                      "جزء تبارك  ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          textBaseline: TextBaseline.ideographic),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        child: Text(
                      "    العام: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    )),
                    Text(
                      "2023   ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          textBaseline: TextBaseline.ideographic),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                            child: Text(
                          " المجموعة: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        )),
                        Text(
                          " الآولى  ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              textBaseline: TextBaseline.ideographic),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onScaleStart: (ScaleStartDetails details) {
                print(details);
                _previousScale = _scale;
                setState(() {});
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                print(details);
                _scale = _previousScale * details.scale;
                setState(() {});
              },
              onScaleEnd: (ScaleEndDetails details) {
                print(details);

                _previousScale = 1.0;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                  child: /* Image.asset(
                        "${images[0]}") 
                        */
                      Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(0.1),
                        1: FractionColumnWidth(0.1),
                        2: FractionColumnWidth(0.2),
                        3: FractionColumnWidth(0.1),
                        4: FractionColumnWidth(0.2),
                        5: FractionColumnWidth(0.1),
                        6: FractionColumnWidth(0.1),
                        7: FractionColumnWidth(0.1)
                      },
                      children: [
                        buildRow([
                          "اليوم",
                          "التاريخ",
                          "موضع الحفظ",
                          "العلامة",
                          "موضع المراجعة",
                          "العلامة",
                          "الحضور",
                          "تمت المشاهدة"
                        ], isHeader: true),
                        for (int i = 0; i < 6; i++)
                          buildRow(["", "", "", "", " ", "", "", " "],
                              isHeader: false)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }
}

TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map((cell) {
      TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 10);

      return Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: Text("$cell")),
      );
    }).toList());

 // builtable() {}

