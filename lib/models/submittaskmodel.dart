// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:planetpulse/models/fetchedmodel.dart';

class SubmittaskModel {
  final User user;
  final dynamic task;
  final String image;
  final String extradetail;

  SubmittaskModel(
      {required this.user,
      required this.task,
      required this.image,
      required this.extradetail});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'task': task,
      'image': image,
      'extradetail': extradetail,
    };
  }

  factory SubmittaskModel.fromMap(Map<String, dynamic> map) {
    return SubmittaskModel(
      user: map['user'] as User,
      task: map['task'] as dynamic,
      image: map['image'] as String,
      extradetail: map['extradetail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmittaskModel.fromJson(String source) =>
      SubmittaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
