class C_Favourite {
  int? save_id;
  int? counselor_id;
  int? acc_id;
  String? studentname;
  String? student_id;
  String? semester;
  String? phone_num;
  String? email;

  C_Favourite({
    this.save_id,
    this.counselor_id,
    this.acc_id,
    this.studentname,
    this.student_id,
    this.semester,
    this.phone_num,
    this.email,
  });

  factory C_Favourite.fromJson(Map<String, dynamic> json) => C_Favourite(
        save_id: int.parse(json['save_id']),
        counselor_id: int.parse(json['counselor_id']),
        acc_id: int.parse(json['acc_id']),
        studentname: json['studentname'],
        student_id: json['student_id'],
        semester: json['semester'],
        phone_num: json['phone_num'],
        email: json['email'],
      );
}
