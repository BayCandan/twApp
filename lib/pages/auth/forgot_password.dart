import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twapp/service/auth_service.dart';

class forgotPage extends StatefulWidget {
  const forgotPage({super.key});

  @override
  State<forgotPage> createState() => _SignUpState();
}

class _SignUpState extends State<forgotPage> {
  late String email;
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
                decoration: BoxDecoration(
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
                      customSizedBox(),
                      customSizedBox(),
                      customSizedBox(),
                      signUpButton(),
                      backToLoginPage()
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

  TextButton signUpButton() {
    return TextButton(
      onPressed: () async {
        // final result = await authService.forgotPassword(email);  // hata veren kod
        final result = await authService.forgotPassword;
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("email kontrol et "),
            ),
          );
          Navigator.pop(context, "/loginPage");
        } else {
          print("hata var");
        }
      },
      child: Center(
        child: Text(
          "Kod Gonder",
          style: TextStyle(color: Colors.pink.shade200),
        ),
      ),
    );
  }
  

 
  TextButton backToLoginPage() {
    return TextButton(
      onPressed: () => Navigator.pop(context, "/loginPage"),
      child: Center(
        child: Text(
          "Giris Sayfasina Geri Don",
          style: TextStyle(color: Colors.pink.shade200),
        ),
      ),
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

  Text tittleText() {
    return Text(
      "Hay Aksi! \nEmail'ini Yaz Halledelim",
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
