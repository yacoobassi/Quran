import 'package:flutter/material.dart';

import '../Controller.dart';
import '../lecture/dropdown.dart';
import 'gettable.dart';

class bottomInfo extends StatefulWidget {
  AsyncSnapshot<dynamic> snapshot;
  int i;

  bottomInfo(this.snapshot, this.i);

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
          DataTable(
            columns: [
              DataColumn(
                  label: Text("معدل المراجعة",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
              DataColumn(
                  label: Text("معدل الحفظ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(TextField(
                  decoration: InputDecoration(
                    hintText: widget
                        .snapshot.data['data'][widget.i]['reviewAvarege']
                        .toString(),
                  ),
                  textAlign: TextAlign.center,
                  enabled: false,
                )),
                DataCell(TextField(
                  decoration: InputDecoration(
                    hintText: widget
                        .snapshot.data['data'][widget.i]['studyAvarege']
                        .toString(),
                  ),
                  textAlign: TextAlign.center,
                  enabled: false,
                )),
              ]),
              DataRow(cells: [
                DataCell(Text("سلوك الطالب", style: TextStyle(fontSize: 20))),
                DataCell(droplist(
                    Appreciation, widget.snapshot.data['data'][widget.i]['act'],
                    (newValue) {
                  setState(() {
                    print(widget.snapshot.data['data'][widget.i]['act']);
                    widget.snapshot.data['data'][widget.i]['act'] = newValue;
                  });
                })),
              ]),
              DataRow(cells: [
                DataCell(
                    Text("الصلاة في المسجد", style: TextStyle(fontSize: 20))),
                DataCell(droplist(Appreciation,
                    widget.snapshot.data['data'][widget.i]['sala'], (newValue) {
                  setState(() {
                    widget.snapshot.data['data'][widget.i]['sala'] = newValue;
                  });
                })),
              ]),
              DataRow(cells: [
                DataCell(
                    Text("ملحوظات المدرس", style: TextStyle(fontSize: 20))),
                DataCell(TextField(
                  decoration: InputDecoration(
                    hintText: widget.snapshot.data['data'][widget.i]['notes']
                        .toString(),
                  ),
                  onChanged: (val) {
                    setState(() {
                      widget.snapshot.data['data'][widget.i]['notes'] = val;
                    });
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(
                    Text("عدد أيام الغياب", style: TextStyle(fontSize: 20))),
                DataCell(TextField(
                  decoration: InputDecoration(
                    hintText: widget.snapshot.data['data'][widget.i]['notcome']
                        .toString(),
                  ),
                  textAlign: TextAlign.center,
                  enabled: false,
                )),
              ]),
            ],
            dividerThickness: 0,
            dataRowHeight: 50,
            headingRowHeight: 60,
            columnSpacing: 20,
            horizontalMargin: 20,
            headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Cairo',
                color: Colors.blue),
            dataTextStyle: TextStyle(
                fontSize: 18, fontFamily: 'Cairo', color: Colors.black),
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
        ],
      ),
    );
  }
}
