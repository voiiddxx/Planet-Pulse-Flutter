import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterUser {
  final String username;
  final String email;
  final String password;
  final String company;
  RegisterUser({
    required this.username,
    required this.email,
    required this.password,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'company': company,
    };
  }

  factory RegisterUser.fromMap(Map<String, dynamic> map) {
    return RegisterUser(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      company: map['company'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterUser.fromJson(String source) =>
      RegisterUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
