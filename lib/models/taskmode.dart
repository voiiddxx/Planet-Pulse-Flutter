import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final String task_title;
  final String task_detail;
  final String task_guidlines;
  final String task_image;
  final String task_level;
  TaskModel({
    required this.task_title,
    required this.task_detail,
    required this.task_guidlines,
    required this.task_image,
    required this.task_level,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_title': task_title,
      'task_detail': task_detail,
      'task_guidlines': task_guidlines,
      'task_image': task_image,
      'task_level': task_level,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      task_title: map['task_title'] as String,
      task_detail: map['task_detail'] as String,
      task_guidlines: map['task_guidlines'] as String,
      task_image: map['task_image'] as String,
      task_level: map['task_level'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
