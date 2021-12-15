import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deployproj/model/userProfile.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference mentorsCollection = FirebaseFirestore.instance.collection("Mentor");

  Future checkDocumentExist(String documentId) async{
    final snapShot = await mentorsCollection.doc(documentId).get();
    return snapShot;
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
    double rating,
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