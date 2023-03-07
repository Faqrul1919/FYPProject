class Intake {
  final String intake_id;
  final String months;

  Intake({required this.intake_id, required this.months});

  factory Intake.fromjson(Map<String, dynamic> json) {
    return Intake(
      intake_id: json['intake_id'] as String,
      months: json['months'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "intake_id": intake_id != null ? intake_id.toString() : '',
      "months": months != null ? months.toString() : '',
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "intake_id": intake_id != null ? intake_id.toString() : '',
      "months": months != null ? months.toString() : '',
    };
  }
}
