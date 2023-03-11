import 'package:flutter/material.dart';

class tableTitle extends StatefulWidget {
  tableTitle();

  List<DataCell> cel1(int cel, var s, int r) {
    List<DataCell> dacel = [];

    for (int i = 2 * r; i < 2 * r + cel; i++) {
      var datacel = DataCell(s[i]);
      dacel.add(datacel);
    }

    return dacel;
  }

  List<DataRow> rowexam(int row, int numc, List celles) {
    List<DataRow> darow = [];
    for (int i = 0; i < row; i++) {
      var datarow = DataRow(cells: cel1(numc, celles, i));
      darow.add(datarow);
    }
    return darow;
  }

  List<DataColumn> col(int col, List t) {
    List<DataColumn> datacol1 = [];
    for (int i = 0; i < col; i++) {
      var datacol = DataColumn(
          label: Text(
        t[i],
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.fade,
        ),
      ));
      datacol1.add(datacol);
    }

    return datacol1;
  }

  Text titles(String s) {
    return Text(
      s,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          overflow: TextOverflow.fade),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
