import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Links.dart';
import 'package:test_ro_run/request.dart';

import '../../User/Data.dart';
import '../Teacher_page/report/lecture/dropdown.dart';

var dataS = [
  {
    'icon': Icon(
      Icons.mosque,
      size: 40,
      color: Colors.green,
    ),
    'title': "المركز",
    "value": "institute_name"
  },
  {
    'icon': Icon(
      Icons.done_outline_rounded,
      size: 40,
      color: Colors.green,
    ),
    'title': "عدد الأجزاء المنجزة ",
    "value": "finishedParts"
  },
  {
    'icon': Icon(
      Icons.timelapse_sharp,
      size: 40,
      color: Colors.green,
    ),
    'title': "الجزء الحالي",
    "value": "currentPart"
  },
  {
    'icon': Icon(
      Icons.font_download_outlined,
      size: 40,
      color: Colors.green,
    ),
    'title': "المعدل التراكمي",
    "value": "mark"
  },
  {
    'icon': Icon(
      Icons.pending_actions_outlined,
      size: 40,
      color: Colors.green,
    ),
    'title': "علامة الامتحان السابق",
    "value": "lastMark"
  },
  {
    'icon': Icon(
      Icons.calendar_month,
      size: 40,
      color: Colors.green,
    ),
    'title': "موعد الامتحان القادم",
    "value": "nextExam"
  }
];

var dataT = [
  {
    'icon': Icon(
      Icons.other_houses,
      size: 40,
      color: Colors.green,
    ),
    'title': "المركز",
    "value": "institute_name"
  },
  {
    'icon': Icon(
      Icons.location_on_outlined,
      size: 40,
      color: Colors.green,
    ),
    'title': "المدينة",
    "value": "country"
  },
  {
    'icon': Icon(
      Icons.work_history_rounded,
      size: 40,
      color: Colors.green,
    ),
    'title': "العمل",
    "value": "lastJob"
  },
  {
    'icon': Icon(
      Icons.bookmark,
      size: 40,
      color: Colors.green,
    ),
    'title': "التخصص",
    "value": "study"
  },
  {
    'icon': Icon(
      Icons.mosque,
      size: 40,
      color: Colors.green,
    ),
    'title': "المسجد",
    "value": "mosque"
  },
  {
    'icon': Icon(
      Icons.phone,
      size: 40,
      color: Colors.green,
    ),
    'title': "رقم الهاتف",
    "value": "Yourphone"
  }
];
AsyncSnapshot<dynamic> getInstitutes;
String institiueName;

class grid extends StatefulWidget {
  double width;
  bool teacher;
  grid({Key myKey, this.width, this.teacher}) : super(key: myKey);

  @override
  State<grid> createState() => _gridState();
}

class _gridState extends State<grid> {
  Requst request = new Requst();
  List institutes = [];

  getInfo() async {
    var response = await request.postRequest(linkGETStData, {
      "num": Data.user != null
          ? Data.user.email.replaceFirst('@gmail.com', '')
          : "",
      "instituteNum": Data.user.institute,
      "regimentNum": Data.user.regiment
    });

    return response;
  }

  getTeacherInfo() async {
    var response = await request.postRequest(linkgetTeacherInfo, {
      "num": Data.user.email.replaceFirst('@gmail.com', ''),
      "instituteNum": Data.user.institute,
      "regimentNum": Data.user.regiment
    });

    getInstitutes = AsyncSnapshot.withData(ConnectionState.done, response);
    institutes.clear();

    for (int i = 0; i < getInstitutes.data['institutes'].length; i++) {
      institutes.add(
          "${getInstitutes.data['institutes'][i]['name']}/${getInstitutes.data['institutes'][i]['num']}/${getInstitutes.data['institutes'][i]['regimentNum']}");
    }
    institiueName = response['data']["institute_name"];
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 240, left: 50, right: 50),
      width: widget.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              List split = institutes.map((e) {
                return e.toString().split("/")[0];
              }).toList();
              if (index == 0 && widget.teacher)
                showDialog(
                  context: context,
                  builder: (con) {
                    return AlertDialog(
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            var collection = await FirebaseFirestore.instance
                                .collection('users');
                            await collection
                                .doc(Data.user.email)
                                .update({'regiment': Data.user.regiment});
                            await collection
                                .doc(Data.user.email)
                                .update({'institute': Data.user.institute});

                            setState(() {});
                          },
                          child: Text("تأكيد"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("إلغاء"),
                        ),
                      ],
                      title: Text(
                        "اختر المركز",
                        style: TextStyle(),
                      ),
                      content: droplist(
                        split,
                        institiueName,
                        // Replace with the default value you want to select
                        (val) {
                          setState(() {
                            int index = split.indexOf(val);

                            var parts = institutes[index].split("/");
                            Data.user.regiment = parts[parts.length - 1];
                            Data.user.institute = parts[parts.length - 2];
                            Data.user.inistituteName = val;
                          });
                        },
                      ),
                    );
                  },
                );
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    !widget.teacher
                        ? dataS[index]['icon']
                        : dataT[index]['icon'],
                    !widget.teacher
                        ? Text(dataS[index]['title'])
                        : Text(dataT[index]['title']),
                    FutureBuilder(
                        future: widget.teacher ? getTeacherInfo() : getInfo(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return widget.teacher
                                ? Text(
                                    "${snapshot.data['data'][dataT[index]['value']]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "${snapshot.data['data'][0][dataS[index]['value']]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  );
                          } else {
                            return Text("");
                          }
                        }))
                  ],
                )),
          );
        },
      ),
    );
  }
}

class institute {
  int num, regimentNum, teacherNum;
  String name, secondTeacher;

  institute(int num, String name, int regimentNum, int teacherNum,
      String secondTeacher) {
    this.num = num;
    this.regimentNum = regimentNum;
    this.teacherNum = teacherNum;
    this.name = name;
    this.secondTeacher = secondTeacher;
  }
}
