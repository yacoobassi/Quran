import 'package:Quran/newChating/Screen_message/ChatMessage.dart';
import 'package:Quran/newChating/components/filled_outline_button.dart';
import 'package:Quran/newChating/components/constants.dart';
import 'package:Quran/newChating/Screen_Chats/Chat.dart';
import 'package:Quran/newChating/Screen_message/message_screen.dart';
import 'package:Quran/newChating/firebase/services/database.dart';
import 'package:Quran/newChating/firebase/services/shared.dart';
import 'package:flutter/material.dart';

import '../firebase/constants.dart';
import 'chat_card.dart';

Stream chatRooms;

class Body extends StatefulWidget {
  String id;
  Body(this.id);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DataBase dataBase = new DataBase();

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        if (snapshot != null) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatRoomsTile(
                      userName: snapshot.data.docs[index]['chatRoomId'],
                      chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                    );
                  })
              : Container();
        }
      },
    );
  }

  saveMyname(AsyncSnapshot snapshot) async {
    {
      Constant.myName = snapshot.data;

      print(Constant.myName);
      await DataBase().getUserChats(Constant.myName).then((snapshots) {
        chatRooms = snapshots;
      });
    }
    return Constant.myName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: helper.getUserName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot != null) {
              saveMyname(snapshot);
              return new Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                    color: Colors.green,
                    child: Row(
                      children: [
                        FillOutlineButton(press: () {}, text: "Recent Message"),
                        SizedBox(width: kDefaultPadding),
                        FillOutlineButton(
                          press: () {},
                          text: "Active",
                          isFilled: false,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: chatRoomsList(),
                    // child: ListView.builder(
                    //   itemCount: chatsData.length,
                    //   itemBuilder: (context, index) => ChatCard(
                    //     chat: chatsData[index],
                    //     press: () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => MessagesScreen(widget.id),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              );
            }
          } else
            return new CircularProgressIndicator();
        });
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagesScreen(
                      chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Text(userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
