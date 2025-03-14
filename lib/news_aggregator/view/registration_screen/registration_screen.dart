import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/news_aggregator/services/user_data.dart';
import 'package:news_app/news_aggregator/view/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(MaterialApp(home: RegistrationScreen(),));
}
class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  UserController controller = Get.put(UserController());
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final cwordController = TextEditingController();
  final regKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";

  registration() async {
    if (emailController.text != "" && passwordController.text != "" &&
        nameController.text != "" && cwordController.text != "" ) {
      controller.saveUserData(nameController.text,emailController.text);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          'Registered SuccessFully', style: TextStyle(fontSize: 20,color: Colors.green),)));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder : (context) => LoginScreen()));
      }
      on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
    'Password provided is too weak',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
    backgroundColor: Colors.orange));
    } else {
    if (e.code == 'email-already-in-use') {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
    'Account already exists', style: TextStyle(fontSize: 18),)));
    }
    }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
        width: width,height: height,
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create your account!",
                style: GoogleFonts.openSans(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.purple),
              ),
              Text(
                "Become a member",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 20),
              Form(key: regKey,
                child:

                Flex(
                  direction: Axis.vertical,
                  children:[ Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child:
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      height: height / 1.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "name",
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
                            child: TextFormField(controller: nameController,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  Get.showSnackbar(GetSnackBar(message: "Please fill name"));
                                }
                              return null;
                            },
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
                          Text(
                            "email",
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
                            child:

                            TextFormField(controller: emailController,
                              validator:  (value){
                                                    if (value == null || value.isEmpty) {
                                                      Get.showSnackbar(GetSnackBar(message: "Please fill email"));
                                                    } else if (!RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(value)) {
                                                      Get.showSnackbar(GetSnackBar(message: "Please fill email2"));
                                                    }
                                                    return null;
                                                    },
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
                          SizedBox(height: 6),
                          Text(
                            "password",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.purpleAccent),
                          ),
                          SizedBox(height: 6),

                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 2, color: Colors.deepPurple)),
                              child:
                              TextFormField(controller: passwordController,
                                validator: (value) => value!.length < 6
                                    ? "Password must be at least 6 characters"
                                    : null,
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_rounded,
                                      color: Colors.purple,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Text(
                            "confirm password",
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
                            child: TextFormField(controller: cwordController,

          validator: (value) => value != passwordController.text
          ? "Must be same as password"
                  : null,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_rounded,
                                    color: Colors.purple,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: (){
                                      if(regKey.currentState!.validate()){
                                        setState(() {
                                          email = emailController.text;
                                          password = passwordController.text;
                                          name = nameController.text;
                                        });
                                        registration();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                      }
                            },
                            child:
                            Container(width: width,height: 34,
                              decoration: BoxDecoration(gradient: LinearGradient(colors: [
                                Colors.deepPurple,Colors.deepPurpleAccent,Colors.purple,Colors.purpleAccent],begin: Alignment.topLeft,end: Alignment.topRight),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(child: Text("Signup",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
                ),
              ),
              SizedBox(height: 15),
              Center(child: Text("Already have an Account?",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.purple),)),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  Get.to(LoginScreen());
                },
                child: Container(height: 34,width: width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [
                    Colors.deepPurple,Colors.deepPurpleAccent,Colors.purple,Colors.purpleAccent],begin: Alignment.topRight,end: Alignment.topLeft),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(child: Text("Signin",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ),
          ],),
        ),
                  ),
      ),
    );
  }
}
