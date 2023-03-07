class Student {
  final String acc_id;
  final String studentname;
  final String student_id;
  final String semester;
  final String phone_num;
  final String email;
  final String passwords;
  final String rating_code;

  Student(
      {required this.acc_id,
      required this.studentname,
      required this.student_id,
      required this.semester,
      required this.phone_num,
      required this.email,
      required this.passwords,
      required this.rating_code});

  factory Student.fromjson(Map<String, dynamic> json) {
    return Student(
      acc_id: json['acc_id'] as String,
      studentname: json['studentname'] as String,
      student_id: json['student_id'] as String,
      semester: json['semester'] as String,
      phone_num: json['phone_num'] as String,
      email: json['email'] as String,
      passwords: json['passwords'] as String,
      rating_code: json['rating_code'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "acc_id": acc_id != null ? acc_id.toString() : '',
      "studentname": studentname != null ? studentname.toString() : '',
      "student_id": student_id != null ? student_id.toString() : '',
      "semester": semester != null ? semester.toString() : '',
      "phone_num": phone_num != null ? phone_num.toString() : '',
      "email": email != null ? email.toString() : '',
      "passwords": passwords != null ? passwords.toString() : '',
      "rating_code": rating_code != null ? rating_code.toString() : '',
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "acc_id": acc_id != null ? acc_id.toString() : '',
      "studentname": studentname != null ? studentname.toString() : '',
      "student_id": student_id != null ? student_id.toString() : '',
      "semester": semester != null ? semester.toString() : '',
      "phone_num": phone_num != null ? phone_num.toString() : '',
      "email": email != null ? email.toString() : '',
      "passwords": passwords != null ? passwords.toString() : '',
      "rating_code": rating_code != null ? rating_code.toString() : '',
    };
  }
}
