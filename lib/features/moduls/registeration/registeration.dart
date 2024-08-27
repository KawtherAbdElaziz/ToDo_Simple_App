import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/firebase_utils.dart';
import 'package:todo_simple_app/core/page_route_names.dart';
import 'package:todo_simple_app/core/services/snack_bar_service.dart';
import 'package:todo_simple_app/core/settings_provider.dart';

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
    var lang = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);

    return Container(
      decoration: BoxDecoration(
          color: provider.isDark() ? Colors.black : Colors.white,
          image: const DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: provider.isDark()
                ? Colors.black
                : Colors.white, // Change this to your desired color
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('login');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 120,
          title: Text(
            lang.creteaAccount,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
                      if (value == null || value.trim().isEmpty) {
                        return "PLZ Enter Your Name";
                      }
                      var regex =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+*-/=?^_`{|}~]");
                      if (!regex.hasMatch(value)) {
                        return "invalid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text(
                          lang.userName,
                          style: TextStyle(
                              color: provider.isDark()
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        hintText: lang.eyName,
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5D9CEC)),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff5D9CEC), width: 2)),
                        suffixIcon: const Icon(
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
                      if (value == null || value.trim().isEmpty) {
                        return "PLZ Enter Your Email";
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+*-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return "invalid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text(
                          lang.email,
                          style: TextStyle(
                              color: provider.isDark()
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        hintText: lang.eyEmail,
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5D9CEC)),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff5D9CEC), width: 2)),
                        suffixIcon: const Icon(
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
                      if (value == null || value.trim().isEmpty) {
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
                        label: Text(
                          lang.password,
                          style: TextStyle(
                              color: provider.isDark()
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        hintText: lang.eyPassword,
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5D9CEC)),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
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
                          FireBaseUtils.createAccount(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMessage(
                                  "Account create successfuly");
                              if (context.mounted) {
                                Navigator.pushNamed(
                                    context, PageRouteNames.login);
                              }
                              if (kDebugMode) {
                                print("Vaild");
                              }
                            }
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lang.creteaAccount,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
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
                      child: Text(lang.haveAccount)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
