import 'package:flutter/material.dart';
import 'package:planetpulse/utils/font/font.dart';

class PostCard extends StatelessWidget {
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
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(postimage), fit: BoxFit.cover),
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
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(userimage), fit: BoxFit.cover),
                      color: Colors.red,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Subtitle(color: Colors.black, text: "void.tsx")
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomFont(
                  color: const Color.fromARGB(255, 29, 29, 29),
                  text: postcaption,
                  weight: FontWeight.w300,
                  size: 12),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.mark_chat_unread_rounded,
                    color: Color.fromARGB(255, 32, 32, 32),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  CustomFont(
                      color: const Color.fromARGB(255, 117, 117, 117),
                      text: "$postlikes Likes",
                      weight: FontWeight.w300,
                      size: 12),
                  const SizedBox(
                    width: 9,
                  ),
                  CustomFont(
                      color: const Color.fromARGB(255, 117, 117, 117),
                      text: " $postcomment Comments",
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
