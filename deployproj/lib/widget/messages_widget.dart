// import 'package:deployproj/api/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deployproj/model/message.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:deployproj/utils.dart';
import 'package:deployproj/widget/message_widget.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatelessWidget {
  final String uid;
  String query;
  AuthService _auth = AuthService();

   MessagesWidget({
    @required this.uid,
    this.query,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('chats/$query/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots(),
        builder: (context, snapshot) {
          print(query);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data.docs;

                return snapshot.data.docs.length <= 0
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          
                          DocumentSnapshot doc = snapshot.data.docs[index];
                          String idUser = doc['idUser'];
                          String username = doc['username'];
                          String message = doc['message'];
                          DateTime createdAt = Utils.toDateTime(doc['createdAt']);
                          Message me = Message(idUser: idUser, username: username, message: message, createdAt: createdAt);

                          return MessageWidget(
                            message: me,
                            isMe: me.idUser ==
                                _auth.loggedInUserID(), // need to chnge the user dynamically
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
