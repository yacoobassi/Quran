import 'package:flutter/material.dart';

import '../../../Chat/screens/auth_screen.dart';
import '../../../Links.dart';
import '../../../request.dart';

class tableExam extends StatefulWidget {
  tableExam(this.collist, this.rowexa, this.numcol, this.numcel, this.snapshot,
      this.delete, this.refresh);
  int rowexa;
  int numcol;
  int numcel;
  List collist;
  bool delete;
  Function refresh;

  AsyncSnapshot<dynamic> snapshot;

  @override
  State<tableExam> createState() => _tableExamState();
}

class _tableExamState extends State<tableExam> {
  Requst request = new Requst();

  deleteStudent(int i) async {
    var response = await request.postRequest(LinkdeleteStudent, {
      "num": widget.snapshot.data['data'][i]['num'],
    });
    print(widget.snapshot.data['data'][0]['num']);
    return response;
  }

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
      columns: col(widget.numcol),
      rows: rowexam(
          widget.snapshot.data['data'].length, widget.numcel, widget.snapshot),
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
    for (int i = widget.delete ? 0 : 1; i < cel; i++) {
      var datacel = DataCell(
        i == 0
            ? ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (con) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await deleteStudent(rowIndex);
                                  widget.refresh();
                                  await DeleteUser.deleteUser(widget.snapshot
                                          .data['data'][rowIndex]['num'] +
                                      "@gmail.com");
                                },
                                child: Text("تأكيد")),
                            ElevatedButton(
                                onPressed: () async {}, child: Text("إلغاء")),
                          ],
                          title: Text(
                            "هل تريد حذف الطالب ",
                            style: TextStyle(),
                          ),
                        );
                      });
                },
                child: Text("حذف"),
              )
            : Text(
                "${snapshot.data['data'][rowIndex][widget.collist[i]['value']]}",
                textAlign: TextAlign.center,
              ),
      );

      if (i == 0 && datacel.child == null) {
        datacel = DataCell(
          ElevatedButton(
            onPressed: () {},
            child: Text("حذف"),
          ),
        );
      }

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
    for (int i = widget.delete ? 0 : 1; i < col; i++) {
      var datacol = DataColumn(
        label: Text(
          widget.collist[i]['title'],
        ),
      );
      datacol1.add(datacol);
    }

    return datacol1;
  }
}
