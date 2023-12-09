import 'package:flutter/material.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';

class ApproveWeeklyTaskScreen extends StatefulWidget {
  const ApproveWeeklyTaskScreen({super.key});

  @override
  State<ApproveWeeklyTaskScreen> createState() =>
      _ApproveWeeklyTaskScreenState();
}

class _ApproveWeeklyTaskScreenState extends State<ApproveWeeklyTaskScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/356036/pexels-photo-356036.jpeg?cs=srgb&dl=pexels-pixabay-356036.jpg&fm=jpg"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFont(
                                      color: GlobalColor.headingcolor,
                                      text:
                                          "Task: Remove Plastic from your area",
                                      weight: FontWeight.w600,
                                      size: 18),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                    "https://images.pexels.com/photos/356036/pexels-photo-356036.jpeg?cs=srgb&dl=pexels-pixabay-356036.jpg&fm=jpg"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomFont(
                                              color: GlobalColor.headingcolor,
                                              text: "Nikhil Kumar",
                                              weight: FontWeight.w600,
                                              size: 18),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          const CustomFont(
                                              color: Color.fromARGB(
                                                  255, 52, 52, 52),
                                              text: "nikhil@gmail.com",
                                              weight: FontWeight.w300,
                                              size: 12),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 248, 184),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const CustomFont(
                                        color: Color.fromARGB(255, 52, 52, 52),
                                        text: "Additinols Details",
                                        weight: FontWeight.w400,
                                        size: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomFont(
                                      color: Color.fromARGB(255, 52, 52, 52),
                                      text:
                                          "This is testing text i dont know what i am writing but this is what it is lemme know how are you feeling about this and i dont know what i am writying again so i am sorry agina",
                                      weight: FontWeight.w400,
                                      size: 12),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 132,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 207, 255, 230),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work_outline_rounded,
                                    color: GlobalColor.headingcolor,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const CustomFont(
                                      color: Color.fromARGB(255, 52, 52, 52),
                                      text: "Task Level: Easy",
                                      weight: FontWeight.w400,
                                      size: 12),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor:
                                            GlobalColor.primarycolor),
                                    onPressed: () {},
                                    child: const CustomFont(
                                        color: Colors.white,
                                        text: "Approve Task",
                                        weight: FontWeight.w500,
                                        size: 13),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: GlobalColor.primarycolor,
                                      elevation: 0,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {},
                                    child: CustomFont(
                                        color: GlobalColor.headingcolor,
                                        text: "Decline Task",
                                        weight: FontWeight.w500,
                                        size: 13),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
