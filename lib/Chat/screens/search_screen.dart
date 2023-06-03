import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../PagesWidgets/Teacher_page/Student/student_informatin.dart';
import '../../User/Data.dart';
import 'chat_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.search);
  bool search;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy("name")
        .startAt([searchController.text])
        .endAt([searchController.text + "\uf8ff"])
        .get()
        .then((value) {
          if (value.docs.length < 1) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("هذا الاسم غير موجود")));
            setState(() {
              isLoading = false;
            });
            return;
          }

          value.docs.forEach((user) {
            if (user.data()['email'] != Data.user.email &&
                user.data()['student'] != Data.user.student &&
                user.data()['regiment'] == Data.user.regiment &&
                user.data()['institute'] == Data.user.institute) {
              searchResult.add(user.data());
            }
          });
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    onSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("البحث"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) {
                      onSearch();
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "أكتب اسم الشخص...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            searchController.text = "";
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return widget.search
                                ? ChatScreen(
                                    currentUser: Data.user,
                                    friendId: searchResult[index]['uid'],
                                    friendName: searchResult[index]['name'],
                                    friendImage: searchResult[index]['image'])
                                : student_Data(searchResult[index]['uid']
                                    .replaceAll("@gmail.com", ""));
                          }));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.network(searchResult[index]['image']),
                          ),
                          title: Text(searchResult[index]['name']),
                          trailing: widget.search
                              ? IconButton(icon: Icon(Icons.message))
                              : Text(""),
                        ),
                      );
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
