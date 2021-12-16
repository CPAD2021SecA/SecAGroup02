class UserData {
  final String idUser;
  final String name;
  final String email;

  const UserData({
    this.idUser,
    this.name,
    this.email
    
  });

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