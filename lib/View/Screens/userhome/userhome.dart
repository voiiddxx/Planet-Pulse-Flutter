import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/components/post/postcard.dart';
import 'package:planetpulse/core/post/postservice.dart';
import 'package:planetpulse/models/fetchedmodel.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => UserHomeScreenState();
}

class UserHomeScreenState extends State<UserHomeScreen> {
  final PostService postService = PostService();

  List<AllPost>? posts;

  void getPostNow() async {
    posts = await postService.fetchPost(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPostNow();
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = Provider.of<AuthProvider>(context).user;

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        backgroundColor: GlobalColor.primarycolor,
        elevation: 0,
        leading: const Icon(
          Icons.all_inclusive_rounded,
          color: Colors.white,
          size: 20,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.profilescreen);
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: NetworkImage(currentuser.userprofile),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('x-aut-token');
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, RoutesNames.loginScreen);
            },
            child: const Icon(
              Icons.logout_sharp,
              color: Colors.white,
              size: 28,
            ),
          ),
          const Icon(
            Icons.logout_sharp,
            color: Color.fromARGB(0, 255, 255, 255),
            size: 20,
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: GlobalColor.primarycolor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey ${currentuser.username}",
                      style: GoogleFonts.leagueGothic(
                          fontSize: 35, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Subtitle(
                        color: Color.fromARGB(255, 214, 214, 214),
                        text: "Welcome to the Growing Pro Planet Community"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 51,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomFont(
                                  color: Colors.black,
                                  text: "Your Rating",
                                  weight: FontWeight.w400,
                                  size: h * 0.016),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  height: h * 0.04,
                                  width: w * 0.13,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 36, 36, 36),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: CustomFont(
                                        color: Colors.white,
                                        text: currentuser.pro_planet_rating
                                            .toString(),
                                        weight: FontWeight.w400,
                                        size: h * 0.016),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 51,
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomFont(
                                  color: Colors.black,
                                  text: "Completed task",
                                  weight: FontWeight.w400,
                                  size: h * 0.016),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: h * 0.04,
                                width: w * 0.12,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 36, 36, 36),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: CustomFont(
                                      color: Colors.white,
                                      text: currentuser.total_completed_task
                                          .toString(),
                                      weight: FontWeight.w400,
                                      size: h * 0.016),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Container(
                      height: h * 0.05,
                      width: w * 0.35,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(47, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: CustomFont(
                            color: Colors.white,
                            text:
                                "Pro Planet Level ${currentuser.pro_planet_level}",
                            weight: FontWeight.w500,
                            size: h * 0.015),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: posts == null ? 2 : posts?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      PostCard(
                        postid: posts == null
                            ? "null"
                            : posts![index].id.toString(),
                        postimage: posts == null
                            ? "null"
                            : posts![index].postimage.toString(),
                        userimage: posts == null
                            ? "null"
                            : posts![index].user.userprofile.toString(),
                        username: posts == null
                            ? "null"
                            : posts![index].user.username,
                        postcaption:
                            posts == null ? "null" : posts![index].title,
                        postlikes: posts == null
                            ? "null"
                            : posts![index].likes.length.toString(),
                        postcomment:
                            posts == null ? "null" : posts![index].comment,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
