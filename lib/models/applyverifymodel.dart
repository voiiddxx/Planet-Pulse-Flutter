import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApplyVerifyModal {
  final String verifytask;
  final String verifyimage;
  ApplyVerifyModal({
    required this.verifytask,
    required this.verifyimage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'verifytask': verifytask,
      'verifyimage': verifyimage,
    };
  }

  factory ApplyVerifyModal.fromMap(Map<String, dynamic> map) {
    return ApplyVerifyModal(
      verifytask: map['verifytask'] as String,
      verifyimage: map['verifyimage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyVerifyModal.fromJson(String source) =>
      ApplyVerifyModal.fromMap(json.decode(source) as Map<String, dynamic>);
}
