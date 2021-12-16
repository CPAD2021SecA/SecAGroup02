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

  static Future uploadMessage(String idUser, String message, String loggedInUser, String loggedInUserName) async {
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