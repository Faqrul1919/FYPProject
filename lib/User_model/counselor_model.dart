class User2 {
  int counselor_id;
  String counselor_name;
  String counselorID;
  String counselor_room;
  String email;
  String passwords;

  User2(this.counselor_id, this.counselor_name, this.counselorID,
      this.counselor_room, this.email, this.passwords);

  factory User2.fromJson(Map<String, dynamic> json) => User2(
        int.parse(json["counselor_id"]),
        json["counselor_name"],
        json["counselorID"],
        json["counselor_room"],
        json["email"],
        json["passwords"],
      );

  Map<String, dynamic> toJson() => {
        'counselor_id': counselor_id.toString(),
        'counselor_name': counselor_name,
        'counselorID': counselorID,
        'counselor_room': counselor_room,
        'email': email,
        'passwords': passwords,
      };
}
