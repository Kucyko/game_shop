import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/signup_model.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/views/shared/custom_textfield.dart';
import 'package:online_shop/views/shared/reusable_text.dart';
import 'package:online_shop/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

import '../../../controllers/login_provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty && username.text.isNotEmpty) {
      validation = true;
    } else {
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
            ReusableText(text: "Please register", style: appstyle(15, Colors.white, FontWeight.normal) ),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              hintText: "Username",
              controller: username,
              validator: (username){
                if(username!.isEmpty) {
                  return "Please provide valid username";
                }else {
                  return null;
                }
              },
            ),

            SizedBox(
              height: 15.h,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                  },
                  child:ReusableText(text: "Login", style: appstyle(15, Colors.white, FontWeight.normal) )),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
                onTap: (){
                  formValidation();
                  if (validation){
                    SignupModel model = SignupModel(
                      username: username.text, email: email.text, password: password.text);
                      authNotifier.registerUser(model).then((response){
                        if(response == true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                        }else{
                          debugPrint('failed to register');
                        }
                      });
                  }else{
                    debugPrint('form not valid');
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
                      child: ReusableText(text: "R E G I S T E R", style: appstyle(18, Colors.black, FontWeight.bold) )),
                )
            )


          ],
        ),

      ),
    );
  }
}
