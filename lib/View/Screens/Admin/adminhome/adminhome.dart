import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/admin.jpg"),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 50, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFont(
                              color: GlobalColor.headingcolor,
                              text: "Hello ${user.username}",
                              weight: FontWeight.w600,
                              size: 25),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(user.userprofile),
                                    fit: BoxFit.contain)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomFont(
                          color: Color.fromARGB(255, 119, 119, 119),
                          text:
                              "Welcome to the growing community pro planet persons! ",
                          weight: FontWeight.w300,
                          size: 15),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: 150,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[50],
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: CustomFont(
                                color: GlobalColor.headingcolor,
                                text: "Assing Task",
                                weight: FontWeight.w400,
                                size: 15)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.approveweekly);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/changed.jpg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/verifychange.jpg"),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
