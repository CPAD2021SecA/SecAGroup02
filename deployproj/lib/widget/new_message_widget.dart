// import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewMessageWidget extends StatefulWidget {
  final String uid;
  String query;
  
   NewMessageWidget({
    @required this.uid,
    this.query,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState(uid: uid, query: query);
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  _NewMessageWidgetState({this.uid, this.query});
  String uid;
  String query;
  final _controller = TextEditingController();
  AuthService _auth = AuthService();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    print("new message");
    print(query);
    DatabaseService.uploadMessage(query, message, _auth.loggedInUserID(), _auth.getName());

    // await FirebaseApi.uploadMessage(widget.idUser, message);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
