import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/View/components/post/postcard.dart';
import 'package:planetpulse/core/post/postservice.dart';
import 'package:planetpulse/models/fetchedmodel.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';

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
          actions: const [
            Icon(
              Icons.add_a_photo_sharp,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 15,
            ),
            Icon(
              Icons.logout_sharp,
              color: Colors.white,
              size: 24,
            ),
            Icon(
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.26,
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
                                text:
                                    "Welcome to the Growing Pro Planet Community"),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 51,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomFont(
                                          color: Colors.black,
                                          text: "Your Rating",
                                          weight: FontWeight.w400,
                                          size: 15),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 35,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 36, 36, 36),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: CustomFont(
                                                color: Colors.white,
                                                text: currentuser
                                                    .pro_planet_rating
                                                    .toString(),
                                                weight: FontWeight.w400,
                                                size: 15),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 51,
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomFont(
                                          color: Colors.black,
                                          text: "Completed task",
                                          weight: FontWeight.w400,
                                          size: 15),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 36, 36, 36),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: CustomFont(
                                              color: Colors.white,
                                              text: currentuser
                                                  .total_completed_task
                                                  .toString(),
                                              weight: FontWeight.w400,
                                              size: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 35,
                              width: 180,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(47, 255, 255, 255),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: CustomFont(
                                    color: Colors.white,
                                    text:
                                        "Pro Planet Level ${currentuser.pro_planet_level}",
                                    weight: FontWeight.w400,
                                    size: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts == null ? 2 : posts?.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      postid:
                          posts == null ? "null" : posts![index].id.toString(),
                      postimage: posts == null
                          ? "null"
                          : posts![index].postimage.toString(),
                      userimage: posts == null
                          ? "null"
                          : posts![index].user.userprofile.toString(),
                      username:
                          posts == null ? "null" : posts![index].user.username,
                      postcaption: posts == null ? "null" : posts![index].title,
                      postlikes: posts == null
                          ? "null"
                          : posts![index].likes.length.toString(),
                      postcomment:
                          posts == null ? "null" : posts![index].comment,
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
