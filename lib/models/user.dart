// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String username;
  final String userprofile;
  final String email;
  final int pro_planet_level;
  final String password;
  List<dynamic>? post;
  final int pro_planet_rating;
  final int total_completed_task;
  final String category;
  final List<dynamic> ques;
  User({
    required this.id,
    required this.username,
    required this.userprofile,
    required this.email,
    required this.pro_planet_level,
    required this.password,
    this.post,
    required this.pro_planet_rating,
    required this.total_completed_task,
    required this.category,
    required this.ques,
  });
}
