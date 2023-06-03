import 'package:flutter/material.dart';
import 'package:test_ro_run/Links.dart';
import 'package:test_ro_run/request.dart';

import '../../User/Data.dart';

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

class grid extends StatelessWidget {
  double width;
  bool teacher;
  grid({Key myKey, this.width, this.teacher}) : super(key: myKey);

  Requst request = new Requst();

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
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 240, left: 50, right: 50),
      width: width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
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
                  !teacher ? dataS[index]['icon'] : dataT[index]['icon'],
                  !teacher
                      ? Text(dataS[index]['title'])
                      : Text(dataT[index]['title']),
                  FutureBuilder(
                      future: teacher ? getTeacherInfo() : getInfo(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return teacher
                              ? Text(
                                  "${snapshot.data['data'][0][dataT[index]['value']]}",
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
              ));
        },
      ),
    );
  }
}
