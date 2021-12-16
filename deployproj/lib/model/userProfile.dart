
class UserProfile{
  String name;
  String uid;
  String photoUrl;
  String specialist;
  String about;
  String domain;
  String ad1;
  String ad2;
  String ah1;
  String ah2;
  int noRating;
  int rating;

  UserProfile mapData(Map<String, dynamic> data){
    this.name = data["name"];
    this.uid = data["uid"];
    this.photoUrl = data["photoUrl"];
    this.specialist = data["specialist"];
    this.about = data["about"];
    this.domain = data["domain"];
    this.ad1 = data["achievementDesc1"];
    this.ad2 = data["achievementDesc2"];
    this.ah1 = data["achivementHead1"];
    this.ah2 = data["achivementHead2"];
    this.rating = data["rating"];
    this.noRating = data["noOfRating"];
    // print(this.toString());
    return this;

  }
}

