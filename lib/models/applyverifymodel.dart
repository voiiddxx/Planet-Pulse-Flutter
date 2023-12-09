import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApplyVerifyModal {
  final String question;
  final String quesImage;
  ApplyVerifyModal({
    required this.question,
    required this.quesImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'quesImage': quesImage,
    };
  }

  factory ApplyVerifyModal.fromMap(Map<String, dynamic> map) {
    return ApplyVerifyModal(
      question: map['question'] as String,
      quesImage: map['quesImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyVerifyModal.fromJson(String source) =>
      ApplyVerifyModal.fromMap(json.decode(source) as Map<String, dynamic>);
}
