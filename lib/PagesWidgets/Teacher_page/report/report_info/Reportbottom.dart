import 'package:flutter/material.dart';

import '../../../../Links.dart';
import '../../../../User/Data.dart';
import '../../../../request.dart';

class ReportBottom extends StatefulWidget {
  ReportBottom(this.setAvg);
  Function setAvg;

  @override
  State<ReportBottom> createState() => _ReportBottomState();
}

class _ReportBottomState extends State<ReportBottom> {
  final request = Requst();

  getavarege() async {
    final response = await request.postRequest(getReportAvarege, {
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getavarege(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          widget.setAvg(
            snapshot.data['data'][0]['tajoeed_avg'],
            snapshot.data['data'][0]['study_avg'].toString(),
            snapshot.data['data'][0]['review_avg'].toString(),
          );
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(width: 7, color: Colors.green)),
            alignment: Alignment.center,
            width: 392,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "المعدل النهائي لجميع الطلبة من 10",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        "حفظ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      child: Text(
                        "مراجعة",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      child: Text(
                        "تجويد",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextF(snapshot.data['data'][0]['study_avg'].toString()),
                    TextF(snapshot.data['data'][0]['review_avg'].toString()),
                    TextF(snapshot.data['data'][0]['tajoeed_avg']),
                  ],
                )
              ],
            ),
          );
        } else
          return SizedBox();
      },
    );
  }
}

class TextF extends StatelessWidget {
  TextF(this.t);
  String t;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5),
      height: 40,
      width: 120,
      decoration:
          BoxDecoration(border: Border.all(width: 3, color: Colors.green)),
      child: Text(
        t,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
