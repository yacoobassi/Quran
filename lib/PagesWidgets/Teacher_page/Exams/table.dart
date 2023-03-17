import 'package:flutter/material.dart';

class tableExam extends StatelessWidget {
  tableExam(this.collist, this.rowexa, this.numcol, this.numcel);
  int rowexa;
  int numcol;
  int numcel;
  List<String> collist;
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
        columns: col(numcol, collist),
        rows: rowexam(rowexa, numcel));
  }

  List<DataCell> cel1(int cel) {
    List<DataCell> dacel = [];

    for (int i = 0; i < cel; i++) {
      var datacel = DataCell(TextField(
        enabled: false,
      ));
      dacel.add(datacel);
    }

    return dacel;
  }

  List<DataRow> rowexam(int row, numc) {
    List<DataRow> darow = [];
    for (int i = 0; i < row; i++) {
      var datarow = DataRow(cells: cel1(numc));
      darow.add(datarow);
    }
    return darow;
  }

  List<DataColumn> col(int col, List s) {
    List<DataColumn> datacol1 = [];
    for (int i = 0; i < col; i++) {
      var datacol = DataColumn(
          label: Text(
        s[i],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ));
      datacol1.add(datacol);
    }

    return datacol1;
  }
}
