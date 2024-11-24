import 'package:alpha/view/pages/signup_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xffEF5A5A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo/logo1.png"),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Read without limits",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const SignUpPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 100)),
                          Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xffEB5757)),
                          ),
                          Padding(padding: EdgeInsets.only(right: 100)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ))
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 25)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                      backgroundColor: const Color(0xffEF5A5A),
                      side: const BorderSide(
                        color: Colors.white
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      )
                  ),
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 100)),
                          Text(
                            "Login as Guest",
                            style: TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          Padding(padding: EdgeInsets.only(right: 100)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ))
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? ",style: TextStyle(color: Colors.white,fontSize: 16),),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                child: const Text("Login",style: TextStyle(color: Colors.cyanAccent,fontSize: 16,fontWeight: FontWeight.bold),),
              )
            ],
          ),
          const Spacer(flex: 5,)
        ],
      ),
    );
  }
}
