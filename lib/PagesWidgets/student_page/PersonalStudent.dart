import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/pages/stdPage.dart';

import '../../Chat/screens/auth_screen.dart';
import '../../Links.dart';
import '../../User/Data.dart';
import '../../pages/posts.dart';
import '../../request.dart';
import '../../tables/tableTitle.dart';
import '../Bar/drawer.dart';
import '../Bar/notification.dart';
import '../Teacher_page/report/lecture/dropdown.dart';

class Personal_student extends StatefulWidget {
  Personal_student(this.student);
  String student;
  @override
  State<Personal_student> createState() => _Personal_studentState();
}

class _Personal_studentState extends State<Personal_student> {
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
  TextEditingController password = TextEditingController();

  String grade;
  String dateS = "";
  bool init = false;

  initial(AsyncSnapshot<dynamic> snapshot) {
    password.text = snapshot.data['data'][0]['password'];

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

  updateName() async {
    try {
      var collection = await FirebaseFirestore.instance.collection('users');

      await collection.doc(Data.user.email).update({
        'name': name.text,
      });
    } catch (e) {
      return;
    }
  }

  update() async {
    var response = await request.postRequest(updateStudentInf, {
      "password": password.text,
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
    await ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));
    updateName();
    return response;
  }

  getInfo() async {
    var response = await request.postRequest(linkGETStData, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "instituteNum": Data.user.institute,
      "reginmentNum": Data.user.regiment
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

  send() async {
    var formdata = formstate.currentState;
    //  if (formdata.validate()) {
    await update();

    await ChangePassword.changeUserPassword(Data.user.email, password.text);
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
      tableTitle().titles('الرقم السري '),
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
      MaterialButton(
        onPressed: () async {
          await send();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => student_page()));
        },
        child: Text(
          "تخزين",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: Colors.green,
      )
    ];

    int numrowexa1 = 13;
    int numcol1 = 2;
    int numcel1 = 2;

    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("البيانات الشخصية"),
        ),
        drawer: drawer(student: true, drawer_width: drawer().drawer_width),
        body: FutureBuilder(
          future: !init ? getInfo() : Future.value(true),
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
                  controller: password,
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
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
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
                  controller: school,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
                Text("")
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
