class Groups {
  final String group_id;
  final String groups;

  Groups({required this.group_id, required this.groups});

  factory Groups.fromjson(Map<String, dynamic> json) {
    return Groups(
      group_id: json['group_id'] as String,
      groups: json['groups'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "group_id": group_id != null ? group_id.toString() : '',
      "groups": groups != null ? groups.toString() : '',
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "group_id": group_id != null ? group_id.toString() : '',
      "groups": groups != null ? groups.toString() : '',
    };
  }
}
