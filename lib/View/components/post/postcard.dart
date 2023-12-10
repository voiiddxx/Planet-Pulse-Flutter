import 'package:flutter/material.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:shimmer/shimmer.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String userimage;
  final String postimage;
  final String postcaption;
  final String postlikes;
  final String postcomment;

  const PostCard(
      {super.key,
      required this.username,
      required this.userimage,
      required this.postimage,
      required this.postcaption,
      required this.postlikes,
      required this.postcomment});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
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
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 30,
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
                  Icon(
                    Icons.favorite_border,
                    color: widget.postlikes == "null"
                        ? Colors.transparent
                        : Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.mark_chat_unread_rounded,
                    color: widget.postlikes == "null"
                        ? Colors.transparent
                        : const Color.fromARGB(255, 61, 61, 61),
                  ),
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
                          text: " ${widget.postcomment} Comments",
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
