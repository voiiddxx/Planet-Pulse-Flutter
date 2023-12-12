import 'package:flutter/material.dart';
import 'package:planetpulse/Routes/routenames.dart';
import 'package:planetpulse/View/components/textfield/textfiled.dart';
import 'package:planetpulse/core/auth/authservice.dart';
import 'package:planetpulse/providers/authprovider.dart';
import 'package:planetpulse/utils/colors/color.dart';
import 'package:planetpulse/utils/font/font.dart';
import 'package:planetpulse/utils/res/snackbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController usernameScontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
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
                    color: GlobalColor.headingcolor,
                    text: "Log in into your account"),
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
                    controller: usernameScontroller,
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
            child: Column(
              children: [
                SizedBox(
                  height: 50,
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
                        dynamic data = await provider.loginUser(
                            username: usernameScontroller.text.trim(),
                            password: passwordController.text.trim(),
                            context: context);
                        print(data);

                        if (data == 200) {
                          Navigator.pushNamed(context, RoutesNames.homescreen);
                        } else {
                          showSnackBar(context, "Some error", Colors.red);
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading == true
                          ? const Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Subtitle(color: Colors.white, text: "Login")),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => {
                    Navigator.pushNamed(context, RoutesNames.registerScreen)
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFont(
                          color: GlobalColor.subtitlecolor,
                          text: "Already have an account? ",
                          weight: FontWeight.w300,
                          size: 15),
                      const CustomFont(
                          color: Color.fromARGB(255, 0, 0, 0),
                          text: "Login Now",
                          weight: FontWeight.w500,
                          size: 15),
                    ],
                  ),
                )
              ],
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
