import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 600,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 192, 192, 192),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFont(
            color: GlobalColor.headingcolor,
            text: "Comments",
            weight: FontWeight.w600,
            size: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: const Color.fromARGB(255, 219, 219, 219),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.yellow,
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1552058544-f2b08422138a?q=80&w=1899&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: "void,tsx",
                              weight: FontWeight.w500,
                              size: 15),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 300,
                            child: CustomFont(
                                color: GlobalColor.headingcolor,
                                text:
                                    "contributing in clean india and green india mission , so happy and looking forward to do more this type of contribution",
                                weight: FontWeight.w300,
                                size: 12),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            color: const Color.fromARGB(255, 189, 189, 189),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(2),
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Write your comment",
                        hintStyle: GoogleFonts.manrope(
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: 12),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 219, 219, 219),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 60,
                  width: 50,
                  decoration: BoxDecoration(
                    color: GlobalColor.primarycolor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
