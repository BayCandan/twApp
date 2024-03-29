import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twapp/pages/auth/sign_up.dart';
import 'package:twapp/service/auth_service.dart';
import 'package:twapp/widgets/customTextButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * .25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/topImage.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tittleText(),
                      customSizedBox(),
                      emailTextField(),
                      customSizedBox(),
                      passwordTextField(),
                      customSizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          forgotPasswordButton(),
                          signUpButton(),
                        ],
                      ),
                      Center(
                        child: signInButton(),
                      ),
                      Center(
                        child: CustomTextButton(
                            onPressed: () async {
                              final result =
                                  await authService.signInAnonymous();
                              if (result != null) {
                                Navigator.pushReplacementNamed(
                                    context, "/homePage");
                              } else {
                                print("hata var");
                              }
                            },
                            buttonText: "Misafir Girisi"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurun";
        } else {}
      },
      onSaved: (value) {
        password = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: custominputDecoration("Sifre"),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurun";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: custominputDecoration("Kullanici Adi"),
    );
  }

  TextButton signInButton() {
    return TextButton(
      onPressed: signIn,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xff31274F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "Giris Yap",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final result = await authService.signIn(email, password);
      if (result == "success") {
        Navigator.pushReplacementNamed(context, "/homePage");
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("HATA"),
                content: Text(result!),
              );
            });
      }
    }
  }

  CustomTextButton signUpButton() {
    return CustomTextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/signUp");
      },
      buttonText: "Hesap Olustur",
    );
  }

  TextButton forgotPasswordButton() {
    return TextButton(
      onPressed: () async {
        final result = await authService.forgotPassword;
        if (result != null) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("email kontrol et "),
          //   ),
          // );
          Navigator.pushNamed(context, "/forgotPage");
        } else {
          print("hata var");
        }
      },
      child: Text(
        "Sifremi Unuttum",
        style: TextStyle(color: Colors.pink.shade200),
      ),
    );
  }

  Text tittleText() {
    return Text(
      "Merhaba, \nHosgeldin",
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  InputDecoration custominputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: 20,
      );
}
