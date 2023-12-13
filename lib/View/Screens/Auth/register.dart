// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/components/textfield/textfiled.dart';
import 'package:planetpulse/core/auth/authservice.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/login.jpg"),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingText(
                    color: GlobalColor.headingcolor, text: "Create Account"),
                const SizedBox(
                  height: 5,
                ),
                Subtitle(
                    color: GlobalColor.subtitlecolor,
                    text: "Let's save the planet with one step"),
                const SizedBox(
                  height: 20,
                ),
                customTextFiled(
                    obscure: false,
                    controller: usernameController,
                    hinttext: "Username",
                    icon: const Icon(
                      Icons.person_sharp,
                      size: 20,
                      color: Color.fromARGB(255, 59, 59, 59),
                    )),
                const SizedBox(
                  height: 20,
                ),
                customTextFiled(
                    obscure: false,
                    controller: emailController,
                    hinttext: "Enter Your Email",
                    icon: const Icon(
                      Icons.email,
                      size: 20,
                      color: Color.fromARGB(255, 59, 59, 59),
                    )),
                const SizedBox(
                  height: 20,
                ),
                customTextFiled(
                    obscure: false,
                    controller: passwordController,
                    hinttext: "*******",
                    icon: const Icon(
                      Icons.lock_outline_sharp,
                      size: 20,
                      color: Color.fromARGB(255, 59, 59, 59),
                    )),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColor.headingcolor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic data = await auth.registeruser(
                          username: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text);

                      if (data == 200) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, RoutesNames.loginScreen);
                        showSnackBar(context, "Account Created", Colors.green);
                      } else {
                        showSnackBar(
                            context, "Invalid Credentials", Colors.red);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : CustomFont(
                            color: Colors.white,
                            text: "Create Now",
                            weight: FontWeight.w500,
                            size: h * 0.018),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () =>
                      {Navigator.pushNamed(context, RoutesNames.loginScreen)},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFont(
                          color: GlobalColor.subtitlecolor,
                          text: "Already have an account?   ",
                          weight: FontWeight.w300,
                          size: h * 0.018),
                      CustomFont(
                          color: Color.fromARGB(255, 72, 109, 255),
                          text: "Login Now",
                          weight: FontWeight.w500,
                          size: h * 0.018),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
