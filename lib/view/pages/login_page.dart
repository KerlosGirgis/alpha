import 'package:alpha/controller/auth_service.dart';
import 'package:alpha/view/pages/navbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("assets/logo/logo2.png")],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 70)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 330,
                  height: 70,
                  child: TextFormField(
                    controller: email,
                    style: const TextStyle(fontSize: 22),
                    maxLines: 1,
                    decoration: InputDecoration(
                        focusColor: Colors.grey,
                        hintStyle:
                            const TextStyle(fontSize: 22, color: Colors.grey),
                        hintText: "Kerlos1@gmail.com",
                        label: const Text("Email"),
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        suffix: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.highlight_remove_sharp,
                              color: Colors.grey,
                            ))),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 330,
                  height: 70,
                  child: TextFormField(
                    controller: password,
                    style: const TextStyle(fontSize: 22),
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                        focusColor: Colors.grey,
                        hintStyle:
                            const TextStyle(fontSize: 22, color: Colors.grey),
                        hintText: "Password",
                        label: const Text("Password"),
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        suffix: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ))),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 70)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: const Color(0xffEB5757),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    onPressed: () async {
                      await AuthService().signIn(email.text, password.text);
                      if (AuthService().isSignedIn()) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navbar()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 75)),
                            Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Padding(padding: EdgeInsets.only(right: 75)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15)),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
