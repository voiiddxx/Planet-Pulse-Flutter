import 'package:flutter/material.dart';
import 'package:planetpulse/View/Screens/weekly/exploreweekly.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  String? taskLevel;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                  color: GlobalColor.headingcolor,
                  text: "Weekly Tasks",
                  weight: FontWeight.bold,
                  size: h * 0.019),
              const SizedBox(
                height: 10,
              ),
              CustomFont(
                  color: GlobalColor.subtitlecolor,
                  text:
                      "To apply for pro planet verification upload the proof of given below tasks and on uploading the fake proofs your points will be deducted",
                  weight: FontWeight.w400,
                  size: h * 0.014),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    taskLevel = "Easy";
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExploreWeeklyTrask(tasklevel: taskLevel!);
                      },
                    ),
                  );
                },
                child: Container(
                  height: h * 0.32,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/task.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    taskLevel = "Medium";
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExploreWeeklyTrask(tasklevel: taskLevel!);
                      },
                    ),
                  );
                },
                child: Container(
                  height: h * 0.32,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/medium.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    taskLevel = "Hard";
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExploreWeeklyTrask(tasklevel: taskLevel!);
                      },
                    ),
                  );
                },
                child: Container(
                  height: h * 0.32,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/hard.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
