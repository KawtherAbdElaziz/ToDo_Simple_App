import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/firebase_utils.dart';
import 'package:todo_simple_app/core/page_route_names.dart';
import 'package:todo_simple_app/core/settings_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isobscured = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 120,
          title: Text(
            lang.login,
            textAlign: TextAlign.center,
          ),
        ),
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
                  Text(lang.welcome,
                      style: theme.textTheme.titleLarge?.copyWith(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w700)),
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
                      return null;
                    },
                    decoration: InputDecoration(
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
                  Text(lang.fpass),
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
                          FireBaseUtils.signAccount(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value) {
                              EasyLoading.dismiss();
                              if (context.mounted) {
                                Navigator.pushNamed(
                                    context, PageRouteNames.layout);
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
                            lang.login,
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
                        Navigator.pushNamed(
                            context, PageRouteNames.registeration);
                      },
                      child: Text(lang.create)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
