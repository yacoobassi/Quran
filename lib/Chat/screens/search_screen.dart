import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/PagesWidgets/Teacher_page/Student/PersonalStudent.dart';
import '../../Links.dart';
import '../../User/Data.dart';
import '../../request.dart';
import 'auth_screen.dart';
import 'chat_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.search, this.delete);
  bool search, delete;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  Requst request = new Requst();

  deleteStudent(String num) async {
    var response = await request.postRequest(LinkdeleteStudent, {
      "num": num,
    });
    return response;
  }

  Future<void> fetchData() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy("name")
        .startAt([searchController.text]).endAt(
            [searchController.text + "\uf8ff"]).get();

    if (querySnapshot.docs.length < 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("هذا الاسم غير موجود")));
      setState(() {
        isLoading = false;
      });
      return;
    }

    querySnapshot.docs.forEach((user) {
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      if (userData['email'] != Data.user.email &&
          userData['student'] != Data.user.student &&
          userData['regiment'] == Data.user.regiment &&
          userData['institute'] == Data.user.institute) {
        searchResult.add(userData);
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  void onDeleteStudent(String uid) async {
    await deleteStudent(uid.replaceAll("@gmail.com", ""));
    await DeleteUser.deleteUser(uid);

    // Remove the deleted user from the searchResult list
    searchResult.removeWhere((user) => user['uid'] == uid);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("تم حذف الطالب ")));
  }

  void onSearch() {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    fetchData();
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  onSearch();
                },
                icon: Icon(Icons.search),
              ),
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
                      if (widget.delete) {
                        showDialog(
                          context: context,
                          builder: (con) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await onDeleteStudent(
                                        searchResult[index]['uid']);
                                    // Remove the deleted user from the searchResult list
                                    if (searchResult.length > 0)
                                      searchResult.removeAt(index);
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
                              title: Text("هل تريد حذف الطالب",
                                  style: TextStyle()),
                            );
                          },
                        );
                        return;
                      }

                      setState(() {
                        searchController.text = "";
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return widget.search
                              ? ChatScreen(
                                  currentUser: Data.user,
                                  friendId: searchResult[index]['uid'],
                                  friendName: searchResult[index]['name'],
                                  friendImage: searchResult[index]['image'],
                                )
                              : PersonalOne1_student(searchResult[index]['uid']
                                  .replaceAll("@gmail.com", ""));
                        }),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.network(searchResult[index]['image']),
                      ),
                      title: Text(searchResult[index]['name']),
                      trailing: widget.search
                          ? IconButton(icon: Icon(Icons.message))
                          : widget.delete
                              ? IconButton(
                                  icon: Icon(Icons.remove_circle_rounded),
                                )
                              : Text(""),
                    ),
                  );
                },
              ),
            )
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
