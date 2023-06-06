import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/report/lecture/dropdown.dart';
import '../../../../request.dart';

List Appreciation = [
  " ",
  "ممتاز",
  "جيد جدا",
  "جيد",
  "مقبول",
  "ضعيف",
];

class gettable extends StatefulWidget {
  AsyncSnapshot<dynamic> snapshot;
  int student;
  gettable(this.snapshot, this.student);
  @override
  State<gettable> createState() => _gettableState();
}

class _gettableState extends State<gettable> {
  Requst request = new Requst();
  String tajoeed = "";

  List<DataRow> rows1() {
    List<DataRow> darow = [];
    if (widget.snapshot.data['data'].length > 0)
      for (int i = 0;
          i < widget.snapshot.data['data'][0]['grades'].length;
          i++) {
        var datarow = DataRow(cells: [
          DataCell(TextFormField(
            decoration: InputDecoration(
              hintText: widget
                  .snapshot.data['data'][widget.student]['grades'][i]['review']
                  .toString(),
            ),
            onChanged: (val) {
              setState(() {
                widget.snapshot.data['data'][widget.student]['grades'][i]
                    ['review'] = val;
              });
            },
          )),
          DataCell(TextFormField(
            decoration: InputDecoration(
              hintText: widget
                  .snapshot.data['data'][widget.student]['grades'][i]['study']
                  .toString(),
            ),
            onChanged: (val) {
              setState(() {
                widget.snapshot.data['data'][widget.student]['grades'][i]
                    ['study'] = val;
              });
            },
          )),
          DataCell(droplist(
              Appreciation,
              widget.snapshot.data['data'][widget.student]['grades'][i]
                  ['tajoeed'], (newValue) {
            setState(() {
              widget.snapshot.data['data'][widget.student]['grades'][i]
                  ['tajoeed'] = newValue;
            });
          })),
          DataCell(Checkbox(
            visualDensity: VisualDensity.standard,
            onChanged: (val) {
              setState(() {
                widget.snapshot.data['data'][widget.student]['grades'][i]
                    ['exist'] = val ? 1 : 0;
              });
            },
            value: widget.snapshot.data['data'][widget.student]['grades'][i]
                    ['exist'] ==
                1,
          ))
        ]);
        darow.add(datarow);
      }

    return darow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        columns: [
          DataColumn(
              label: Text("مراجعة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          DataColumn(
              label: Text("حفظ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          DataColumn(
              label: Text("تجويد",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          DataColumn(
              label: Text("غياب",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
        ],
        rows: rows1(),
        dividerThickness: 0,
        dataRowHeight: 50,
        headingRowHeight: 60,
        columnSpacing: 10,
        horizontalMargin: 10,
        headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Cairo',
            color: Colors.blue),
        dataTextStyle:
            TextStyle(fontSize: 18, fontFamily: 'Cairo', color: Colors.black),
        dataRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected))
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          return Colors.white;
        }),
        headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.grey[300];
        }),
      ),
    );
  }
}
