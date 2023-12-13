import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/Screens/comments/commentscreen.dart';
import 'package:planetpulse/core/impression/impressionservice.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shimmer/shimmer.dart';

class PostCard extends StatefulWidget {
  final String postid;
  final String username;
  final String userimage;
  final String postimage;
  final String postcaption;
  final String postlikes;
  final dynamic postcomment;

  const PostCard(
      {super.key,
      required this.username,
      required this.userimage,
      required this.postimage,
      required this.postcaption,
      required this.postlikes,
      required this.postcomment,
      required this.postid});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final ImpressionService impressionService = ImpressionService();

  void likepost(postid) async {
    await impressionService.LikeThePost(postid: postid);
  }

  bool postLiked = false;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.postimage == "null"
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 212, 212, 212),
                      highlightColor: Colors.white,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.postimage),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.userimage == "null"
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 212, 212, 212),
                          highlightColor: Colors.white,
                          child: Container(
                            height: h * 0.045,
                            width: w * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          height: h * 0.045,
                          width: w * 0.08,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.userimage),
                                fit: BoxFit.cover),
                            color: Colors.red,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.username == "null"
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 212, 212, 212),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Subtitle(color: Colors.black, text: widget.username)
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              widget.postcaption == "null"
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 212, 212, 212),
                      highlightColor: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 10,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 10,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ))
                  : CustomFont(
                      color: const Color.fromARGB(255, 29, 29, 29),
                      text: widget.postcaption,
                      weight: FontWeight.w300,
                      size: 12),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      likepost(widget.postid);
                      setState(() {
                        if (postLiked == true) {
                          postLiked = false;
                        } else {
                          postLiked = true;
                        }
                      });
                    },
                    child: postLiked == true
                        ? Icon(
                            Icons.favorite_rounded,
                            color: widget.postlikes == "null"
                                ? Colors.transparent
                                : Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: widget.postlikes == "null"
                                ? Colors.transparent
                                : Colors.red,
                            size: 25,
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      showBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50))),
                        elevation: 10,
                        context: context,
                        builder: (context) => CommentScreen(
                          postid: widget.postid,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.mark_chat_unread_rounded,
                      color: widget.postlikes == "null"
                          ? Colors.transparent
                          : const Color.fromARGB(255, 61, 61, 61),
                      size: 25,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  widget.postlikes == "null"
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 212, 212, 212),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 82,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : CustomFont(
                          color: const Color.fromARGB(255, 117, 117, 117),
                          text: "${widget.postlikes} Likes",
                          weight: FontWeight.w300,
                          size: 12),
                  const SizedBox(
                    width: 9,
                  ),
                  widget.postcomment == "null"
                      ? Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 212, 212, 212),
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 82,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : CustomFont(
                          color: const Color.fromARGB(255, 117, 117, 117),
                          text: " ${widget.postcomment.length} Comments",
                          weight: FontWeight.w300,
                          size: 12)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
