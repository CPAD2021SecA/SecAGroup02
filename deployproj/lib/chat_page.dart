import 'package:deployproj/model/mentor_model.dart';
import 'package:deployproj/model/user.dart';
import 'package:deployproj/model/userProfile.dart';
import 'package:deployproj/widget/messages_widget.dart';
import 'package:deployproj/widget/new_message_widget.dart';
import 'package:deployproj/widget/profile_header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    this.model,
    Key key,
  }) : super(key: key);

  final UserProfile model;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.model.name),
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
                  child: MessagesWidget(uid: widget.model.uid),
                ),
              ),
              NewMessageWidget(uid: widget.model.uid)
            ],
          ),
        ),
      );
}
