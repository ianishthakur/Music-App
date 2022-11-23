import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/common/constant/routes_strings.dart';
import 'package:music_app/common/shared_pref/shared_pref.dart';
import 'package:music_app/ui/home_page.dart';

import '../../../../common/constant/assets.dart';
import '../../../../common/constant/strings.dart';
import '../common/text_field/register_textfield.dart';

class NavProps {
  final String name;
  final String email;

  NavProps({required this.name, required this.email});
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  onLogin() {
    FocusScope.of(context).unfocus();
    SharedPref.setUserLoggedIn(true);
    Navigator.pushNamed(context, RoutesStrings.homePage);
    arguments:
    NavProps(email: emailController.text, name: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 235, 230, 244),
                      color: Color(0xFF222c33),
                      //color: Color.fromARGB(255, 35, 239, 219),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Hello Again!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bitter(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text("Welcome back you've been missed!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bitter(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          Assets.music,
                          height: 68,
                          width: 68,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      RegisterTextField(
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter Your Name",
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        label: "Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RegisterTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter Your Email",
                        prefixIcon: const Icon(Icons.email_outlined),
                        label: "Email",
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        onPressed: () {
                          SharedPref.setUserLoggedIn(true);
                          Navigator.pushNamed(
                            context,
                            RoutesStrings.homePage,
                            arguments: NavProps(
                              name: nameController.text,
                              email: emailController.text,
                            ),
                          );
                        },
                        color: const Color(0xFF222c33),
                        minWidth: 200,
                        height: 48,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Log in",
                            style: GoogleFonts.bitter(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              indent: 10.0,
                              endIndent: 10.0,
                              color: Color(0xFF222c33),
                              height: 10,
                            ),
                          ),
                          Text(" Or continue with ",
                              style: GoogleFonts.bitter(
                                  textStyle: const TextStyle(
                                color: Color(0xFF222c33),
                                fontSize: 14,
                              ))),
                          const Expanded(
                            child: Divider(
                              thickness: 0.5,
                              indent: 10.0,
                              endIndent: 10.0,
                              color: Color(0xFF222c33),
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(Assets.google),
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                                radius: 32,
                                backgroundImage: AssetImage(Assets.facebook),
                                backgroundColor: Colors.white),
                            CircleAvatar(
                              backgroundImage: AssetImage(Assets.twitter),
                              radius: 32,
                            ),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
