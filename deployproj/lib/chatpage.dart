import 'package:deployproj/chat_page.dart';
import 'package:deployproj/main.dart';
import 'package:deployproj/model/userForMessage.dart';
import 'package:deployproj/profile_page.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:deployproj/widget/chat-body.dart';
import 'package:deployproj/widget/ratings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ChatsPage extends StatelessWidget {
  // const ChatsPage({ Key? key }) : super(key: key);
  ChatsPage({this.usersData});
  List<UserData> usersData = <UserData>[];
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    if (usersData.isEmpty) {
      return Center(
        child: Text("There is no users yet!"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            new Text("Mentizzz Chat"),
            Spacer(),
            // new Text("Welcome "+ _auth.loggedInUser()),
            OutlinedButton.icon(
              onPressed: () async {
                await _auth.logOut();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Logged out successfully.!"),
                ));
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new MyHomePage()));
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
        // title: Text("Mentizzz Chat"),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(child: 
           Column(
            children: [
                    for(UserData data in usersData) _cards(context, data)
                    // ChatBodyWidget(users: usersData)
                  ],
          )
          ,),
        ),
        
       
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );



      Widget _cards(context, UserData model) {
        String query =
         DatabaseService.check(model.idUser, _auth.loggedInUserID());

        // print("ille"+query);
    return Padding(
      
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: SingleChildScrollView(child: 
       GestureDetector(
        onTap: () {
          // DatabaseService().getDocs();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(queryUid: query, name: model.name, uid: model.idUser)));
        },
        child: Row(
          children: <Widget>[
            Container(
              child: Center(child: 
              Text(
                 model.name.substring(0, 2).toUpperCase(), style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 28) ,),
                 ),
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.green,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.shade400,
                      offset: Offset(4, 4),
                    )
                  ]),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 18)),
                SizedBox(height: 5),
                Text(model.email,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    ));
  }

}