import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Chat/screens/auth_screen.dart';
import '../../../Links.dart';
import '../../../User/Data.dart';
import '../../../pages/teacherPage.dart';
import '../../../request.dart';
import '../../../tables/tableTitle.dart';
import '../../Bar/drawer.dart';
import '../report/lecture/dropdown.dart';

class Personal_info extends StatefulWidget {
  Personal_info();

  @override
  State<Personal_info> createState() => _Personal_infoState();
}

class _Personal_infoState extends State<Personal_info> {
  DateTime date = DateTime.now();
  // GlobalKey<FormState> formstate;
  String req = "يجب ملأ هذه الخانة";
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController preWork = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController university = TextEditingController();
  TextEditingController certificate = TextEditingController();
  TextEditingController tajoeed = TextEditingController();
  TextEditingController mosque = TextEditingController();
  TextEditingController teacher = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController password = TextEditingController();

  Requst request = new Requst();
  String social = "متزوج";
  String tajoeedLevel = "أتقن التجويد وحصلت على شهادة";
  String dateS = "";
  bool init = false;

  initial(AsyncSnapshot<dynamic> snapshot) {
    password.text = snapshot.data['data']['password'];
    name.text = snapshot.data['data']['name'];
    id.text = snapshot.data['data']['id'];
    country.text = snapshot.data['data']['country'];
    work.text = snapshot.data['data']['currentJob'];
    preWork.text = snapshot.data['data']['lastJob'];
    qualification.text = snapshot.data['data']['study'];
    university.text = snapshot.data['data']['university'];
    certificate.text = snapshot.data['data']['certificate'];
    tajoeed.text = snapshot.data['data']['tajoeedLevel'];
    mosque.text = snapshot.data['data']['mosque'];
    teacher.text = snapshot.data['data']['personTeachYou'];
    location.text = snapshot.data['data']['region'];
    phone.text = snapshot.data['data']['Yourphone'];
    telephone.text = snapshot.data['data']['housePhone'];
    remark.text = snapshot.data['data']['remark'];
    if (snapshot.data['data']['social'] != "")
      social = snapshot.data['data']['social'];
    if (snapshot.data['data']['tajoeedYear'] != "")
      tajoeedLevel = snapshot.data['data']['tajoeedYear'];
    if (snapshot.data['data']['birth'] != "")
      dateS = snapshot.data['data']['birth'];
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

  send() async {
    //var formdata = formstate.currentState;
    // if (formdata.validate()) {
    await update();
    await updateName();
    await ChangePassword.changeUserPassword(Data.user.email, password.text);

    Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => teacher_page()));
  }

  update() async {
    var response = await request.postRequest(linkupdateTeacherInfo, {
      "password": password.text,
      "name": name.text,
      "id": id.text,
      "country": country.text,
      "birth": dateS,
      "social": social,
      "currentJob": work.text,
      "lastJob": preWork.text,
      "study": qualification.text,
      "university": university.text,
      "certificate": certificate.text,
      "tajoeedLevel": tajoeed.text,
      "tajoeedYear": tajoeedLevel,
      "mosque": mosque.text,
      "personTeachYou": teacher.text,
      "region": location.text,
      "Yourphone": phone.text,
      "housePhone": telephone.text,
      "remark": remark.text,
      "num": Data.user.email.replaceAll("@gmail.com", "")
    });
    await ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("تمت حفظ البيانات")));
    return response;
  }

  getInfo() async {
    var response = await request.postRequest(linkgetTeacherInfo, {
      "num": Data.user.email.replaceAll("@gmail.com", ""),
      "instituteNum": Data.user.institute,
      "regimentNum": Data.user.regiment
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    // formstate = GlobalKey<FormState>();
    List marride = ["متزوج", "غير متزوج"];
    List<String> tagweed = [
      "أتقن التجويد وحصلت على شهادة",
      "أتقن التجويد وليس معي شهادة",
      "غير ذلك"
    ];
    List title = [
      tableTitle().titles('الاسم الرباعي'),
      tableTitle().titles('الرقم السري'),
      tableTitle().titles('رقم الهوية'),
      tableTitle().titles(
        'البلد',
      ),
      tableTitle().titles('تاريخ الولادة'),
      tableTitle().titles('الحالة الجتماعية '),
      tableTitle().titles('العمل الحالي'),
      tableTitle().titles(' العمل السابق إن وجد'),
      tableTitle().titles(' المؤهل العلمي'),
      tableTitle().titles('الجامعة أو المعهد الذي تخرجت منه'),
      tableTitle().titles('أي شهادة أخرى'),
      tableTitle().titles('مستوى التجويد'),
      tableTitle().titles('في حالة الحصول على شهادة تجويد في أي سنة '),
      tableTitle().titles(' المسجد الذي تعلمت فيه التجويد'),
      tableTitle().titles(' الشيخ الذي تعلمت على يديه '),
      tableTitle().titles('العنوان'),
      tableTitle().titles('رقم الهاتف الشخصي'),
      tableTitle().titles('رقم الهاتف الأرضي'),
      tableTitle().titles('أي ملاحظات أخرى'),
      MaterialButton(
        onPressed: send,
        child: Text(
          "تخزين",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: Colors.green,
      )
    ];

    int numrowexa1 = 35;

    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("البيانات الشخصية"),
      ),
      drawer: drawer(student: false, drawer_width: drawer().drawer_width),
      body: FutureBuilder(
        future: !init ? getInfo() : Future.value(true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!init) initial(snapshot);

            List contain = [
              Container(
                height: 40,
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 40,
                child: TextFormField(
                  controller: password,
                  keyboardType: TextInputType.name,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 20,
                child: TextFormField(
                  controller: id,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 20,
                child: TextFormField(
                  controller: country,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2050))
                      .then((value) {
                    setState(() {
                      date = value;
                      dateS = "${date.year}/${date.month}/${date.day}";
                    });
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      dateS,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
              droplist(marride, social, (val) {
                setState(() {
                  social = val;
                });
              }),
              Container(
                height: 20,
                child: TextFormField(
                  controller: work,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  height: 20,
                  child: TextFormField(
                    controller: preWork,
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                  )),
              Container(
                height: 20,
                child: TextFormField(
                  controller: qualification,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  height: 20,
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                    controller: university,
                  )),
              Container(
                  height: 20,
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                    controller: certificate,
                  )),
              Container(
                height: 60,
                child: Expanded(
                  // add Expanded to have your dropdown button fill remaining space
                  child: DropdownButton<String>(
                    isExpanded:
                        true, // this allows your dropdown icon to be visible
                    value: tajoeedLevel,
                    iconSize: 24,
                    items: tagweed.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item, overflow: TextOverflow.clip),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        tajoeedLevel = value;
                      });
                    },
                  ),
                ),
              ),
              Container(
                  height: 20,
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                    controller: tajoeed,
                  )),
              Container(
                height: 20,
                child: TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                  controller: mosque,
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                  height: 20,
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                    controller: teacher,
                  )),
              Container(
                height: 20,
                child: TextFormField(
                  controller: location,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 20,
                child: TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return req;
                    }
                    return null;
                  },
                  controller: telephone,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                  height: 20,
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty) {
                        return req;
                      }
                      return null;
                    },
                    controller: remark,
                  )),
              Text("")
            ];

            var celles = [];
            for (int i = 0; i < title.length; i++) {
              celles.add(title[i]);
              celles.add(contain[i]);
            }

            return Form(
              //  key: formstate,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  "images/quran.png",
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              Table(
                                children: List.generate(
                                  numrowexa1,
                                  (index) => index % 2 == 0
                                      ? TableRow(children: [
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                celles[index].data,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: celles[index + 1],
                                            ),
                                          ),
                                        ])
                                      : null,
                                ).where((element) => element != null).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            send();
                          },
                          child: Text(
                            "تخزين",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
