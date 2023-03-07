class User {
  int acc_id;
  String student_name;
  String student_id;
  String semester;
  String phone_num;
  String email;
  String passwords;
  String rating_code;

  User(this.acc_id, this.student_name, this.student_id, this.semester,
      this.phone_num, this.email, this.passwords, this.rating_code);

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json["acc_id"]),
        json["studentname"],
        json["student_id"],
        json["semester"],
        json["phone_num"],
        json["email"],
        json["passwords"],
        json["rating_code"],
      );

  Map<String, dynamic> toJson() => {
        'acc_id': acc_id.toString(),
        'studentname': student_name,
        'student_id': student_id,
        'semester': semester,
        'phone_num': phone_num,
        'email': email,
        'passwords': passwords,
        'rating_code': rating_code,
      };
}

class RegisteredSubject {
  int? stud_reg;
  int? acc_id;
  int? subject_id;
  int? group_id;
  int? intake_id;
  String? studentname;
  String? student_id;
  String? semester;
  String? phone_num;
  String? email;
  String? title;
  String? groups;
  String? months;
  String? avg_rating;

  RegisteredSubject(
      {this.stud_reg,
      this.acc_id,
      this.subject_id,
      this.group_id,
      this.intake_id,
      this.studentname,
      this.student_id,
      this.semester,
      this.phone_num,
      this.email,
      this.title,
      this.groups,
      this.months,
      this.avg_rating});

  factory RegisteredSubject.fromJson(Map<String, dynamic> json) =>
      RegisteredSubject(
        stud_reg: int.parse(json["stud_reg"]),
        acc_id: int.parse(json["acc_id"]),
        subject_id: int.parse(json["subject_id"]),
        group_id: int.parse(json["group_id"]),
        intake_id: int.parse(json["intake_id"]),
        studentname: json['studentname'],
        student_id: json['student_id'],
        semester: json['semester'],
        phone_num: json['phone_num'],
        title: json['title'],
        email: json['email'],
        groups: json['groups'],
        months: json['months'],
        avg_rating: json["avg_rating"],
      );
}

class Student_Favourite {
  int? save_id;
  int? acc_id;
  int? member_id;
  String? studentname;
  String? student_id;
  String? semester;
  String? phone_num;
  String? email;
  String? avg_rating;

  Student_Favourite(
      {this.save_id,
      this.acc_id,
      this.member_id,
      this.studentname,
      this.student_id,
      this.semester,
      this.phone_num,
      this.email,
      this.avg_rating});

  factory Student_Favourite.fromJson(Map<String, dynamic> json) =>
      Student_Favourite(
        save_id: int.parse(json['save_id']),
        acc_id: int.parse(json['acc_id']),
        member_id: int.parse(json['member_id']),
        studentname: json['studentname'],
        student_id: json['student_id'],
        semester: json['semester'],
        phone_num: json['phone_num'],
        email: json['email'],
        avg_rating: json["avg_rating"],
      );
}
