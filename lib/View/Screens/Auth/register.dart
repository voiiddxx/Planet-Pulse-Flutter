import 'package:flutter/material.dart';
import 'package:planetpulse/View/components/textfield/textfiled.dart';
import 'package:planetpulse/core/auth/authservice.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    )),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalColor.headingcolor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    authService.createUserAccount(
                        username: usernameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        context: context);
                  },
                  child:
                      const Subtitle(color: Colors.white, text: "Create Now")),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
