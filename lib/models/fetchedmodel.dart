import 'dart:convert';

List<AllPost> allPostFromJson(String str) =>
    List<AllPost>.from(json.decode(str).map((x) => AllPost.fromJson(x)));

String allPostToJson(List<AllPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPost {
  String id;
  User user;
  String title;
  String postimage;
  List<Like> likes;
  List<Comment> comment;
  int v;

  AllPost({
    required this.id,
    required this.user,
    required this.title,
    required this.postimage,
    required this.likes,
    required this.comment,
    required this.v,
  });

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        title: json["title"],
        postimage: json["postimage"],
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        comment:
            List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "title": title,
        "postimage": postimage,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
        "__v": v,
      };
}

class Comment {
  User user;
  String commentdetail;
  String id;

  Comment({
    required this.user,
    required this.commentdetail,
    required this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: User.fromJson(json["user"]),
        commentdetail: json["commentdetail"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "commentdetail": commentdetail,
        "_id": id,
      };
}

class User {
  String username;
  String userprofile;
  String email;
  int proPlanetLevel;
  String password;
  List<dynamic> posts;
  int proPlanetRating;
  int totalCompletedTask;
  Category? category;
  List<dynamic> ques;
  String id;
  int v;

  User({
    required this.username,
    required this.userprofile,
    required this.email,
    required this.proPlanetLevel,
    required this.password,
    required this.posts,
    required this.proPlanetRating,
    required this.totalCompletedTask,
    this.category,
    required this.ques,
    required this.id,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        userprofile: json["userprofile"],
        email: json["email"],
        proPlanetLevel: json["pro_planet_level"],
        password: json["password"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        proPlanetRating: json["pro_planet_rating"],
        totalCompletedTask: json["total_completed_task"],
        category: categoryValues.map[json["category"]],
        ques: List<dynamic>.from(json["ques"].map((x) => x)),
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "userprofile": userprofile,
        "email": email,
        "pro_planet_level": proPlanetLevel,
        "password": password,
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "pro_planet_rating": proPlanetRating,
        "total_completed_task": totalCompletedTask,
        "category": categoryValues.reverse[category],
        "ques": List<dynamic>.from(ques.map((x) => x)),
        "_id": id,
        "__v": v,
      };
}

enum Category { USER }

final categoryValues = EnumValues({"user": Category.USER});

class Like {
  User user;
  String id;

  Like({
    required this.user,
    required this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        user: User.fromJson(json["user"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "_id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
