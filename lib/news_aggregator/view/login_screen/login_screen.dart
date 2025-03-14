import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/news_aggregator/components/bottomnav_bar/bottom_nav_bar2.dart';
import 'package:news_app/news_aggregator/view/registration_screen/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

    String email = "";
    String password = "";

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
       Get.to(HomeScreen());

    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        GetSnackBar(
            titleText: Text(
              'No User found with this email',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            backgroundColor: Colors.white,
          );
      } else if (e.code == "wrong-password") {
          GetSnackBar(
            titleText: Text(
              'Wrong password provided by the user',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            backgroundColor: Colors.white,
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
          Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          height: height,
          width: width,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: GoogleFonts.openSans(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.purple),
              ),
              Text(
                "Login to get started ",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.purpleAccent),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  height: height / 2.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "username",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.purpleAccent),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2, color: Colors.deepPurple)),
                        child: TextField(controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.purple,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "password",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.purpleAccent),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2, color: Colors.deepPurple)),
                        child: TextField(controller: passwordController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Colors.purple,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot password?",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.purpleAccent),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        child: GestureDetector(
                          onTap: (){
if(emailController.text != "" && passwordController.text != ""){
  setState(() {
    email = emailController.text;
    password = passwordController.text;
  });
  userLogin();
}
                          },

                          child: Container(width: width,height: 34,
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [
                            Colors.deepPurple,Colors.deepPurpleAccent,Colors.purple,Colors.purpleAccent],begin: Alignment.topLeft,end: Alignment.topRight),
                            borderRadius: BorderRadius.circular(15)),
                            child: Center(child: Text("Signin",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                  child: Text(
                    'or',
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(height: 5),
              Flexible(
                child: Container(
                  height: 34,width: width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [
                    Colors.deepPurple,Colors.deepPurpleAccent,Colors.purple,Colors.purpleAccent],begin: Alignment.topLeft,end: Alignment.topRight),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/google_icon.png',
                        height: 26,
                        width: 26,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Login with Google',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
          SizedBox(height: 15),
            Center(child: Text("Don't you have an Account?",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.purple),)),
          SizedBox(height: 5),
          GestureDetector(onTap: (){
            Get.to(RegistrationScreen());
          },
            child: Container(height: 34,width: width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [
                Colors.deepPurple,Colors.deepPurpleAccent,Colors.purple,Colors.purpleAccent],begin: Alignment.topRight,end: Alignment.topLeft),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text("Signup",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
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