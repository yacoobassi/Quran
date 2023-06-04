import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class dateTable extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;

  dateTable(this.snapshot);

  @override
  State<dateTable> createState() => _dateTableState();
}

class _dateTableState extends State<dateTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
            label: Text("التاريخ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      ],
      rows: rows1(),
      dividerThickness: 0,
      dataRowHeight: 50,
      headingRowHeight: 60,
      columnSpacing: 20,
      horizontalMargin: 0,
      headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Cairo',
          color: Colors.blue),
      dataTextStyle:
          TextStyle(fontSize: 18, fontFamily: 'Cairo', color: Colors.black),
      dataRowColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected))
          return Theme.of(context).colorScheme.primary.withOpacity(0.08);
        return Colors.white;
      }),
      headingRowColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Colors.grey[300];
      }),
    );
  }

  List<DataRow> rows1() {
    List<DataRow> darow = [];

    for (int i = 0; i < widget.snapshot.data['data'][0]['grades'].length; i++) {
      var date = widget.snapshot.data['data'][0]['grades'][i]['date'];
      var formattedDate = DateFormat('yyyy-MM-dd').parse(date);
      var cell = DataCell(
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            DateFormat.yMd('ar').format(formattedDate),
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
      var datarow = DataRow(cells: [cell]);
      darow.add(datarow);
    }

    return darow;
  }
}
