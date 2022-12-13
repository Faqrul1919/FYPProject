class Review {
  int? comment_id;
  int? acc_id;
  double? rating;
  String? comments;

  Review({
    this.comment_id,
    this.acc_id,
    this.rating,
    this.comments,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        comment_id: int.parse(json["comment_id"]),
        acc_id: int.parse(json["acc_id"]),
        rating: double.parse(json["rating"]),
        comments: json['comments'],
      );
}

class StudentDB {
  int? acc_id;
  String? studentname;
  String? student_id;
  String? semester;
  String? phone_num;
  String? email;

  StudentDB({
    this.acc_id,
    this.studentname,
    this.student_id,
    this.semester,
    this.phone_num,
    this.email,
  });

  factory StudentDB.fromJson(Map<String, dynamic> json) => StudentDB(
        acc_id: int.parse(json["acc_id"]),
        studentname: json["studentname"],
        student_id: json["student_id"],
        semester: json["semester"],
        phone_num: json["phone_num"],
        email: json["email"],
      );
}
