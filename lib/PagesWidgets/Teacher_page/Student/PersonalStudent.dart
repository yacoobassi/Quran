import 'package:flutter/material.dart';
import 'package:test_ro_run/Links.dart';
import 'package:test_ro_run/PagesWidgets/Bar/drawer.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/report/lecture/dropdown.dart';
import 'package:test_ro_run/User/Data.dart';
import 'package:test_ro_run/request.dart';
import 'package:test_ro_run/tables/tableTitle.dart';

class PersonalOne1_student extends StatefulWidget {
  PersonalOne1_student(this.student);
  String student;
  @override
  State<PersonalOne1_student> createState() => _PersonalOne1_studentState();
}

class _PersonalOne1_studentState extends State<PersonalOne1_student> {
  DateTime date = DateTime.now();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  String req = "يجب ملأ هذه الخانة";
  Requst request = new Requst();
  TextEditingController name = TextEditingController();
  TextEditingController fatherPhone = TextEditingController();
  TextEditingController motherPhone = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController institute = TextEditingController();

  String grade;
  String dateS = "";
  bool init = false;

  initial(AsyncSnapshot<dynamic> snapshot) {
    name.text = snapshot.data['data'][0]['name'];
    id.text = snapshot.data['data'][0]['id'];
    fatherPhone.text = snapshot.data['data'][0]['fatherPhone'];
    motherPhone.text = snapshot.data['data'][0]['motherPhone'];
    school.text = snapshot.data['data'][0]['school'];
    id.text = snapshot.data['data'][0]['id'];
    institute.text = snapshot.data['data'][0]['institute_name'];
    if (snapshot.data['data'][0]['grade'] != "")
      grade = snapshot.data['data'][0]['grade'];
    else
      grade = "-";
    if (snapshot.data['data'][0]['birth'] != "-")
      dateS = snapshot.data['data'][0]['birth'];
    else
      dateS = "${date.year}/${date.month}/${date.day}";

    init = true;
  }

  update() async {
    var response = await request.postRequest(updateStudentInf, {
      "name": name.text,
      "id": id.text,
      "grade": grade,
      "birth": dateS,
      "fatherPhone": fatherPhone.text,
      "motherPhone": motherPhone.text,
      "school": school.text,
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment,
      "num": Data.user.email.replaceAll("@gmail.com", "")
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));
    return response;
  }

  getInfo() async {
    var response = await request.postRequest(linkGETStData, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "instituteNum": Data.user.institute,
      "regimentNum": Data.user.regiment
    });

    return response;
  }

// Mohammad add this
  geonetInfo() async {
    var response = await request.postRequest(linkGETStData, {
      "num": widget.student,
      "instituteNum": Data.user.institute.toString(),
      "reginmentNum": Data.user.regiment.toString(),
    });
    return response;
  }

  void _showDatePikcer() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2050))
        .then((value) {
      setState(
        () {
          date = value;
          dateS = "${date.year}/${date.month}/${date.day}";
        },
      );
    });
  }

  send() {
    var formdata = formstate.currentState;
    //  if (formdata.validate()) {
    update();
    //   }
  }

  @override
  Widget build(BuildContext context) {
    List alsaf = [
      "-",
      "أصغر من أول",
      "أول",
      "الثاني",
      "الثالث",
      "الرابع",
      "الخامس",
      "السادس",
      "السابع",
      "الثامن",
      "التاسع",
      "أكبر من التاسع"
    ];
    List Appreciation = [
      " ",
      "ممتاز",
      "جيد جدا",
      "جيد",
      "مقبول",
      "ضعيف",
    ];

    List<String> co = ["  ", " "];
    List title = [
      tableTitle().titles('رقم الطالب '),
      tableTitle().titles('الاسم الرباعي'),
      tableTitle().titles('رقم الهوية'),
      tableTitle().titles(
        'الصف',
      ),
      tableTitle().titles('المستوى الدراسي'),
      tableTitle().titles('تاريخ الولادة'),
      tableTitle().titles('رقم جوال الأب'),
      tableTitle().titles('رقم جوال الأم'),
      tableTitle().titles('الفوج'),
      tableTitle().titles('المركز'),
      tableTitle().titles('المدرسة'),
    ];

    int numrowexa1 = 11;
    int numcol1 = 2;
    int numcel1 = 2;

    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("البيانات الشخصية"),
        ),
        drawer: drawer(student: false, drawer_width: drawer().drawer_width),
        body: FutureBuilder(
          future: !init ? geonetInfo() : Future.value(true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!init) initial(snapshot);
              List contain = [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Data.user.email.replaceAll("@gmail.com", ""),
                  ),
                  enabled: false,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: name,
                  enabled: false,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  enabled: false,
                  controller: id,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                droplist(alsaf, grade, (val) {
                  setState(() {
                    grade = val;
                  });
                }),
                droplist(Appreciation, "ممتاز", null),
                MaterialButton(
                  color: Colors.green,
                  onPressed: _showDatePikcer,
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        dateS,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  controller: fatherPhone,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  controller: motherPhone,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Data.user.regiment,
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                  enabled: false,
                ),
                TextFormField(
                  controller: institute,
                  style: TextStyle(color: Colors.black38),
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                  enabled: false,
                ),
                TextFormField(
                  enabled: false,
                  controller: school,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ];

              var celles = [];
              for (int i = 0; i < title.length; i++) {
                celles.add(title[i]);
                celles.add(contain[i]);
              }
              return Center(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Form(
                      key: formstate,
                      child: Column(
                        children: [
                          DataTable(
                            dataRowHeight: 70,
                            dataTextStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: TableBorder(
                              bottom: BorderSide(color: Colors.green),
                              top: BorderSide(color: Colors.green),
                              horizontalInside: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid),
                            ),
                            columns: tableTitle().col(numcol1, co),
                            rows: tableTitle()
                                .rowexam(numrowexa1, numcel1, celles),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
