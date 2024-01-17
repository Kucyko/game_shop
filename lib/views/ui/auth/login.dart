import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/models/login_model.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/views/shared/custom_textfield.dart';
import 'package:online_shop/views/shared/reusable_text.dart';
import 'package:online_shop/views/ui/auth/registration.dart';
import 'package:provider/provider.dart';

import '../mainscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool  validation = false;
  void formValidation(){
    if(email.text.isNotEmpty && password.text.isNotEmpty){
      validation = true;
    }else{
      validation = false;
    }
  }
  @override
  Widget build(BuildContext context){
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(text: "Welcome!", style: appstyle(30, Colors.white, FontWeight.w600) ),
            ReusableText(text: "Please log into your account", style: appstyle(15, Colors.white, FontWeight.normal) ),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
                keyboard: TextInputType.emailAddress,
                hintText: "Email",
                controller: email,
                validator: (email){
                  if(email!.isEmpty && !email.contains("@")) {
                    return "Please provide valid email";
                  }else {
                    return null;
                  }
                },
            ),

            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
                hintText: "Password",
                obscureText: authNotifier.isObsecure,
                controller: password,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: authNotifier.isObsecure? Icon(Icons.visibility):Icon(Icons.visibility_off),
              ),
              validator: (password){
                if(password!.isEmpty && password.length < 7) {
                  return "Please provide valid password";
                }else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Registration()));
                  },
                child:ReusableText(text: "Register", style: appstyle(15, Colors.white, FontWeight.normal) )),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: (){
                formValidation();
                if(validation){
                  LoginModel model = LoginModel(email: email.text, password: password.text);
                  authNotifier.userLogin(model).then((response){
                    if (response = true) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                    }else{
                      debugPrint('Failed to login');
                    }
                  });
                }else{
                  debugPrint("form not validated");
                }
              },
              child: Container(
                height: 50.h,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child:  Center(
                  child: ReusableText(text: "L O G I N", style: appstyle(18, Colors.black, FontWeight.bold) )),
                )
              )


            ],
          ),

        ),
      );
  }
}