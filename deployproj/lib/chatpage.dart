import 'package:deployproj/model/userForMessage.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:flutter/material.dart';
// class ChatsPage extends StatelessWidget {
//   // const ChatsPage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Mentizzz Chat"),
    //   ),
    //   body: SafeArea(
    //     child: StreamBuilder<List<UserData>>(stream: DatabaseService.getChatUsers(),
    //           builder: (context, snapshot) {
    //             switch(snapshot.connectionState){
    //               case ConnectionState.waiting:
    //                           return Center(child: CircularProgressIndicator());
    //             default:
    //               if(snapshot.hasError){
    //                 return buildText('Something went wrong.!');
    //               } else{
    //                           final users = snapshot.data;
    //                           if(user)
    //                           return Column(
    //                             children: [
    //                               // ChatBodyWidget(users: users)
    //                             ],
    //                           );
    //               }
    //           }
    //           },
    //     ),

        // child: Column(
        //   children: [
        //     // ChatBodyWidget(users: users)
        //   ],
        // ),
  //     ),
  //   );
  // }

//   Widget buildText(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       );
// }