import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/report/lecture/dropdown.dart';

List Appreciation = [
  " ",
  "ممتاز",
  "جيد جدا",
  "جيد",
  "مقبول",
  "ضعيف",
];

class gettable extends StatefulWidget {
  gettable();
  @override
  State<gettable> createState() => _gettableState();
}

class _gettableState extends State<gettable> {
  List<bool> check = [false];
  List<DataRow> rows1() {
    List<DataRow> darow = [];
    for (int i = 0; i < 15; i++) {
      var datarow = DataRow(cells: [
        DataCell(TextField(
          keyboardType: TextInputType.number,
        )),
        DataCell(TextField(
          keyboardType: TextInputType.number,
        )),
        DataCell(droplist(Appreciation, " ")),
        DataCell(Checkbox(
          visualDensity: VisualDensity.standard,
          onChanged: (val) {
            setState(() {
              check[i] = !check[i];
            });
          },
          value: check[i],
        ))
      ]);
      darow.add(datarow);
      check.add(false);
    }
    return darow;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder(
          left: BorderSide(width: 5),
          right: BorderSide(width: 5),
          top: BorderSide(width: 5),
          bottom: BorderSide(width: 5),
          horizontalInside: BorderSide(),
          verticalInside: BorderSide()),
      columns: [
        DataColumn(label: Text("مراجعة")),
        DataColumn(label: Text("حفظ")),
        DataColumn(label: Text("تجويد")),
        DataColumn(label: Text("غياب")),
      ],
      rows: rows1(),
    );
  }
}
