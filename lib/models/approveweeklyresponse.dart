import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApproveWeeklyModel {
  final String userid;
  final String task_level;
  final String submitid;
  ApproveWeeklyModel({
    required this.userid,
    required this.task_level,
    required this.submitid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'task_level': task_level,
      'submitid': submitid,
    };
  }

  factory ApproveWeeklyModel.fromMap(Map<String, dynamic> map) {
    return ApproveWeeklyModel(
      userid: map['userid'] as String,
      task_level: map['task_level'] as String,
      submitid: map['submitid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveWeeklyModel.fromJson(String source) =>
      ApproveWeeklyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
