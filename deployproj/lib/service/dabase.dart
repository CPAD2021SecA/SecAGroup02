import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deployproj/model/message.dart';
import 'package:deployproj/model/userForMessage.dart';
import 'package:deployproj/model/userProfile.dart';
import 'package:deployproj/utils.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference mentorsCollection = FirebaseFirestore.instance.collection("Mentor");


  Future checkDocumentExistForUser(String documentId) async{
    return FirebaseFirestore.instance.collection("Users").doc(documentId).get();
    
  }

  Future checkDocumentExist(String documentId) async{
    final snapShot = await mentorsCollection.doc(documentId).get();
    print(snapShot.data());
    return snapShot;
  }

  Future updateUserDetails(String id, String name, String email) async{
    return await FirebaseFirestore.instance.collection("Users").doc(id).set({
      "id": id,
      "name": name,
      "email": email
    }
    );
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
  
  // static Future check1(String id){}

  static Future details(String id1, String id2) async{
    print(id1);
    print(id2);

    // if(id1.substring(0,1) > id2.substring(0,1))

    QuerySnapshot<Map<String, dynamic>> _query1 =
        await FirebaseFirestore.instance.collection('chats/$id1/messages').get();
         QuerySnapshot<Map<String, dynamic>> _query2 =
        await FirebaseFirestore.instance.collection('chats/$id2/messages').get();
        if(_query1.docs.isNotEmpty){
          // print("true");
          return id1;
        }

        if(_query2.docs.isNotEmpty){
          // print("2true");
          return id2;
        }
        else{
          // print(id1);
          // print("this is taken");
          return id1;
        }
    // final snap = await FirebaseFirestore.instance.collection('chats').doc(id1).get();
    // print(snap.exists);
    // final snap2 = await FirebaseFirestore.instance.collection('chats').doc(id2).get();
    // print(snap2.exists);

  }

  static Future doubleCheck(String id) async{
    QuerySnapshot<Map<String, dynamic>> _query1 =
        await FirebaseFirestore.instance.collection('chats/$id/messages').get();
        if(_query1.docs.isNotEmpty){
          return id;
        }
        else{
          return id;
        }
  }

  static String check(String idUser, String loginUser) {
    String uniId1 = idUser.substring(0, 4)+loginUser.substring(0,4);
    String uniId2 = loginUser.substring(0,4)+idUser.substring(0,4);
    int n =uniId1.compareTo(uniId2);
    if(n<0){
      print(uniId1);
      return uniId1;
    }
    else{
       print(uniId2);
      return uniId2;
    }
    String finalId = '';
    // details(uniId1, uniId2).then((value) {
    //   return value;
    // });
    // dynamic d =details(uniId1, uniId2);
    
    // print("checkckckckc");
    // return finalId;
    // print(temp.);
  //  final check1 =  FirebaseFirestore.instance.collection('chats/$uniId1/messages').id;
  //   final check2 =  FirebaseFirestore.instance.collection('chats/$uniId2/messages').id;
  //   print(check1);
  //   print(check2);
  //   if(check1 == null){
  //      print("Came here1");
  //     if(check2 == null){
  //       print("came here");
  //       finalId = uniId1;
  //     }
  //     else{
  //       print("hahaha");
  //       finalId = uniId2;
  //     };

  //   }
  //   else{
  //     print("huhuhuh");
  //     finalId = uniId1;
  //   }
  //   print(finalId);
  //   return finalId;
  }

  static Future uploadMessage(String idUser, String message, String loggedInUser, String loggedInUserName) async {
    // String uniId1 = idUser+loggedInUser;
    // String uniId2 = loggedInUser+idUser;
    // String finalId = '';
    // final check1 = await FirebaseFirestore.instance.collection('chats/$uniId1/messages').get();
    // final check2 = await FirebaseFirestore.instance.collection('chats/$uniId2/messages').get();
    // if(check1 == null){
       
    //   if(check2 == null){
    //     finalId = uniId1;
    //   }
    //   else{
    //     finalId = uniId2;
    //   }
    // }
    // else{
    //   finalId = uniId1;
    // }
    print("this is id");
    print(idUser);
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: loggedInUser,
      username: loggedInUserName,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    // final refUsers = FirebaseFirestore.instance.collection('users');
    // await refUsers
    //     .doc(idUser)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<UserData>> getChatUsers() => FirebaseFirestore.instance
    .collection("Users")
    .snapshots()
    .transform(Utils.transformer(UserData.fromJson));


  List<UserData> getDocsForUser(){
    UserData userData = UserData();
    List<UserData> userList = <UserData>[];
    FirebaseFirestore.instance.collection("Users").get().then((value) => 
      value.docs.map((e) {
        userData = UserData();
        userList.add(userData.mapData(e.data() as Map));
        print(e.data() as Map);
      }).toList()
    );
    return userList;
  }

  List<UserProfile> getDocs(String filter)  {
    UserProfile profile = UserProfile();
    List<UserProfile> prof = <UserProfile>[];
     mentorsCollection.where("domain", isEqualTo: filter).get().then((value) => 
      value.docs.map((e) {
        profile = UserProfile();
        prof.add(profile.mapData(e.data() as Map));
        print(e.data() as Map);
      }).toList()
    
    );
    // await mentorsCollection.where("domain", isEqualTo: "ENTERTAINMENT").get().then((value) {
    //   value.docs.map((e) {
    //     print(e.data());
    //   });
    // });
    return prof;
  }

  Future updateMentorDetails(
    String domain,
    String photoUrl,
    String specialist,
    String about,
    String achivementHead1,
    String achievementDesc1,
    String achivementHead2,
    String achievementDesc2,
    int rating,
    int numberOfRatings,
    String name,
    String uid
  ) async {
    return await mentorsCollection.doc(uid).set({
      "domain": domain,
      "photoUrl": photoUrl,
      "specialist": specialist,
      "about": about,
      "achievementDesc1": achievementDesc1,
      "achivementHead1": achivementHead1,
      "achievementDesc2": achievementDesc2,
      "achivementHead2": achivementHead2,
      "rating": rating,
      "noOfRating": numberOfRatings,
      "uid": uid,
      "name": name
    });
  }

}