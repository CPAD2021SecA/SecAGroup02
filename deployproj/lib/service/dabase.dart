import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference mentorsCollection = FirebaseFirestore.instance.collection("Mentor");

  Future updateMentorDetails(
    String domain,
    String photoUrl,
    String specialist,
    String currentRole,
    String degree,
    String experience,
    String areaExpertise,
    String achivementHead1,
    String achievementDesc1,
    String achivementHead2,
    String achievementDesc2,
    double rating,
    int numberOfRatings
  ) async {
    return await mentorsCollection.doc(uid).set({
      "domain": domain,
      "photoUrl": photoUrl,
      "specialist": specialist,
      "currentRole": currentRole,
      "qualification": degree,
      "experience": experience,
      "areaExpertise": areaExpertise,
      "achievementDesc1": achievementDesc1,
      "achivementHead1": achivementHead1,
      "achievementDesc2": achievementDesc1,
      "achivementHead2": achivementHead1,
      "rating": rating,
      "noOfRating": numberOfRatings
    });
  }

}