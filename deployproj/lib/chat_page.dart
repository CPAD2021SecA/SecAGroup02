import 'package:deployproj/model/mentor_model.dart';
import 'package:deployproj/model/user.dart';
import 'package:deployproj/model/userForMessage.dart';
import 'package:deployproj/model/userProfile.dart';
import 'package:deployproj/widget/messages_widget.dart';
import 'package:deployproj/widget/new_message_widget.dart';
import 'package:deployproj/widget/profile_header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    this.name,
    this.uid,
    this.queryUid,
    Key key,
  });

   String name;
   String uid;
   String queryUid;
  @override
  _ChatPageState createState() => _ChatPageState(name: name, uid: uid, query: queryUid);
}

class _ChatPageState extends State<ChatPage> {
  _ChatPageState({this.name, this.uid, this.query});
  String name;
  String uid;
  String query;
  
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(25),
                    //   topRight: Radius.circular(25),
                    // ),
                  ),
                  child: MessagesWidget(uid: uid, query: query),
                ),
              ),
              NewMessageWidget(uid: uid, query: query)
            ],
          ),
        ),
      );
}
