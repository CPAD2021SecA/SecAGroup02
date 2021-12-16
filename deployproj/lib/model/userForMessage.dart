class UserData {
   String idUser;
   String name;
   String email;

   UserData({
    this.idUser,
    this.name,
    this.email
    
  });

  UserData mapData(Map<String, dynamic> data){
    this.name = data["name"];
    this.idUser = data["id"];
    this.email = data["email"];
    // print(this.toString());
    return this;

  }

  // User copyWith({
  //   String idUser,
  //   String name,
  //   String urlAvatar,
  //   String lastMessageTime,
  // }) =>
  //     User(
  //       idUser: idUser ?? this.idUser,
  //       name: name ?? this.name,
  //       urlAvatar: urlAvatar ?? this.urlAvatar,
  //       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
  //     );

  static UserData fromJson(Map<String, dynamic> json) => UserData(
        idUser: json['id'],
        name: json['name'],
        email: json['email']
      );

  Map<String, dynamic> toJson() => {
        'id': idUser,
        'name': name,
        'email': email
      };
}