import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApproveVerifyModel {
  final String id;
  final String postid;
  ApproveVerifyModel({
    required this.id,
    required this.postid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'postid': postid,
    };
  }

  factory ApproveVerifyModel.fromMap(Map<String, dynamic> map) {
    return ApproveVerifyModel(
      id: map['id'] as String,
      postid: map['postid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveVerifyModel.fromJson(String source) =>
      ApproveVerifyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
