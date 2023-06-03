import 'package:flutter/material.dart';

class tableExam extends StatelessWidget {
  tableExam(this.collist, this.rowexa, this.numcol, this.numcel, this.snapshot);
  int rowexa;
  int numcol;
  int numcel;
  List collist;

  AsyncSnapshot<dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black,
      ),
      dataTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      dividerThickness: 2,
      columnSpacing: 16,
      horizontalMargin: 16,
      columns: col(numcol),
      rows: rowexam(snapshot.data['data'].length, numcel, snapshot),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
      ),
    );
  }

  List<DataCell> cel1(int cel, int rowIndex, AsyncSnapshot<dynamic> snapshot) {
    List<DataCell> dacel = [];

    for (int i = 0; i < cel; i++) {
      var datacel = DataCell(
        Text(
          "${snapshot.data['data'][rowIndex][collist[i]['value']]}",
          textAlign: TextAlign.center,
        ),
      );
      dacel.add(datacel);
    }

    return dacel;
  }

  List<DataRow> rowexam(int row, int numc, AsyncSnapshot<dynamic> snapshot) {
    List<DataRow> darow = [];
    for (int i = 0; i < row; i++) {
      var datarow = DataRow(
        color: MaterialStateColor.resolveWith(
            (states) => i % 2 == 0 ? Colors.grey[200] : Colors.white),
        cells: cel1(numc, i, snapshot),
      );
      darow.add(datarow);
    }
    return darow;
  }

  List<DataColumn> col(int col) {
    List<DataColumn> datacol1 = [];
    for (int i = 0; i < col; i++) {
      var datacol = DataColumn(
        label: Text(
          collist[i]['title'],
        ),
      );
      datacol1.add(datacol);
    }

    return datacol1;
  }
}
