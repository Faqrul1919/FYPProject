class Subject {
  final String sub_id;
  final String title;

  Subject({required this.sub_id, required this.title});

  factory Subject.fromjson(Map<String, dynamic> json) {
    return Subject(
      sub_id: json['subject_id'] as String,
      title: json['title'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "subject_id": sub_id != null ? sub_id.toString() : '',
      "title": title != null ? title.toString() : '',
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "subject_id": sub_id != null ? sub_id.toString() : '',
      "title": title != null ? title.toString() : '',
    };
  }
}
