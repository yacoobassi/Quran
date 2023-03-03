import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  getStudentByname(String name) async {
    return await FirebaseFirestore.instance
        .collection('students')
        .where('name', isEqualTo: name)
        .get();
  }

  getStudentByStartName(String name) async {
    if (name.isNotEmpty) {
      return await FirebaseFirestore.instance
          .collection('students')
          .where(
            'name',
            isGreaterThanOrEqualTo: name,
            isLessThan: name.substring(0, name.length - 1) +
                String.fromCharCode(name.codeUnitAt(name.length - 1) + 1),
          )
          .get();
    } else {
      return await FirebaseFirestore.instance
          .collection('students')
          .where(
            'name',
          )
          .get();
    }
  }

  getStudentByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .get();
  }

  getAllStudent(String name) async {
    return await FirebaseFirestore.instance
        .collection('students')
        .where('name')
        .get();
  }

  uploadStudentInfo(StudentMap) {
    FirebaseFirestore.instance.collection("students").add(StudentMap);
  }

  Future<bool> addChatRoom(chatRoomId, chatRoom) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  addChatMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chat")
        .add(messageMap);
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chat")
        .snapshots();
  }

  getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
