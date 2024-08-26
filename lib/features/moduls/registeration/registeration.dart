import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_simple_app/core/page_route_names.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  static String routName = "Registeration";

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isobscured = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 120,
          title: const Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Poppins"),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuery.size.height * 0.2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xff5D9CEC),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "PLZ Enter Your Name";
                      }
                      var regex =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+*-/=?^_`{|}~]");
                      if (!regex.hasMatch(value)) {
                        return "invalid Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("User Name"),
                        hintText: "Enter Your Name",
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff5D9CEC), width: 2)),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Color(0xff5D9CEC),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xff5D9CEC),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "PLZ Enter Your Email";
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+*-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return "invalid Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "Enter Your Email",
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff5D9CEC), width: 2)),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Color(0xff5D9CEC),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: isobscured,
                    cursorColor: const Color(0xff5D9CEC),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "PLZ Enter Your Password";
                      }
                      // var regex = RegExp(
                      //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+*-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      // if (!regex.hasMatch(value)) {
                      //   return "invalid Email";
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: const Text("Password"),
                        hintText: "Enter Your Password",
                        enabledBorder: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff5D9CEC), width: 2)),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isobscured = !isobscured;
                            });
                          },
                          child: Icon(
                            isobscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xff5D9CEC),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 18),
                          backgroundColor: const Color(0xff5D9CEC),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (kDebugMode) {
                            print("Vaild");
                          }
                          Navigator.pushNamed(context, PageRouteNames.login);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Acount",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 30,
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageRouteNames.login);
                      },
                      child: const Text("Or Have Account?")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
