class Counselor {
  final String counselor_id;
  final String counselor_name;
  final String counselorID;
  final String counselor_room;
  final String email;
  final String passwords;

  Counselor(
      {required this.counselor_id,
      required this.counselor_name,
      required this.counselorID,
      required this.counselor_room,
      required this.email,
      required this.passwords});

  factory Counselor.fromjson(Map<String, dynamic> json) {
    return Counselor(
      counselor_id: json['counselor_id'] as String,
      counselor_name: json['counselor_name'] as String,
      counselorID: json['counselorID'] as String,
      counselor_room: json['counselor_room'] as String,
      email: json['email'] as String,
      passwords: json['passwords'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "counselor_id": counselor_id != null ? counselor_id.toString() : '',
      "counselor_name": counselor_name != null ? counselor_name.toString() : '',
      "counselorID": counselorID != null ? counselorID.toString() : '',
      "counselor_room": counselor_room != null ? counselor_room.toString() : '',
      "email": email != null ? email.toString() : '',
      "passwords": passwords != null ? passwords.toString() : '',
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "counselor_id": counselor_id != null ? counselor_id.toString() : '',
      "counselor_name": counselor_name != null ? counselor_name.toString() : '',
      "counselorID": counselorID != null ? counselorID.toString() : '',
      "counselor_room": counselor_room != null ? counselor_room.toString() : '',
      "email": email != null ? email.toString() : '',
      "passwords": passwords != null ? passwords.toString() : '',
    };
  }
}
