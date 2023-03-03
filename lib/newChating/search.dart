import 'package:Quran/widgets/Bar/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Screen_message/message_screen.dart';
import 'firebase/constants.dart';
import 'firebase/services/database.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

DataBase database = new DataBase();
String id;

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
  QuerySnapshot searchSnapshot;

  Widget studentsList() {
    return searchSnapshot != null
        ? Container(
            margin: EdgeInsets.only(top: 75),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchSnapshot.docs.length,
                itemBuilder: (context, index) {
                  return student(
                    name: searchSnapshot.docs[index].get('name'),
                    email: searchSnapshot.docs[index].get('email'),
                  );
                }),
          )
        : Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Search();
  }

  Search() async {
    await database.getStudentByStartName(searchController.text).then((val) {
      searchSnapshot = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                Container(
                    width: 30,
                    height: 30,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.search)),
                Expanded(
                    child: TextField(
                  onChanged: (val) async {
                    Search();
                    studentsList();

                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(hintText: "ابحث عن طالب"),
                )),
              ]),
            ),
            studentsList()
          ],
        ));
  }
}

class student extends StatelessWidget {
  final name;
  final email;
  student({this.email, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                  child: Image.asset(
                "images/face.jpg",
                colorBlendMode: BlendMode.modulate,
                height: 60.0,
                width: 60.0,
                fit: BoxFit.fill,
              )),
              Column(
                children: [Text(name), Text(email)],
              )
            ],
          ),
        ),
      ),
      onTap: () async {
        id = await getChatId(name, Constant.myName);

        List<String> users = [name, Constant.myName];
        Map<String, dynamic> chatMap = {'users': users, 'chatRoomId': id};
        await database.addChatRoom(id, chatMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagesScreen(
                      id,
                    )));
      },
    );
  }

  getChatId(String a, String b) async {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b$a";
    } else {
      return "$a$b";
    }
  }
}
