import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

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
                      passwordTextField(),
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
      onPressed: signIn,
      child: Center(
        child: Text(
          "Hesap Olustur",
          style: TextStyle(color: Colors.pink.shade200),
        ),
      ),
    );
  }

  void signIn() async {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        try {
          var userResult = await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          formkey.currentState!.reset();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Hesap Olusturuldu, Giris Sayfasina Yonlendirilioyrsunuz"),
            ),
          );
          Navigator.pop(context, "/loginPage");
        } catch (e) {
          print(e.toString());
        }
      } else {}
    }

  TextButton backToLoginPage() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, "/loginPage"),
      child: Center(
        child: Text(
          "Giris Sayfasina Geri Don",
          style: TextStyle(color: Colors.pink.shade200),
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
