
import 'package:flutter/material.dart';
import 'package:online_shop/controllers/login_provider.dart';
import 'package:online_shop/services/authhelper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/reusable_text.dart';
import 'package:online_shop/views/shared/tiles_widget.dart';
import 'package:online_shop/views/ui/cartpage.dart';
import 'package:online_shop/views/ui/favorites.dart';
import 'package:online_shop/views/ui/homepage.dart';
import 'package:online_shop/views/ui/mainscreen.dart';
import 'package:online_shop/views/ui/nonuser.dart';
import 'package:provider/provider.dart';

import '../../models/profile_model.dart';
import 'auth/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false ? const NonUser() : Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE2E2E2),
          elevation: 0,
          leading: const Icon(MaterialCommunityIcons.gamepad,
            size: 18,
            color: Colors.black,
          ),
          actions: [
            GestureDetector(
                onTap: () {},
                child: Padding(padding: EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/images/usa.svg', width: 15, height: 25),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 15.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        ReusableText(text: " USA",
                            style: appstyle(
                                16, Colors.black, FontWeight.normal)),

                        SizedBox(
                          width: 10.w,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 4),
                            child: Icon(
                              SimpleLineIcons.settings,
                              color: Colors.black,
                              size: 18,
                            )
                        )
                      ],
                    )
                )
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 66.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 35.h,
                                  width: 35.w,
                                  child: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/user.jpeg'),
                                  )
                              ),

                              SizedBox(
                                width: 8,
                              ),

                              FutureBuilder(
                                future: AuthHelper().getProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: ReusableText(
                                        text: "Error getting the data",
                                        style: appstyle(18, Colors.black, FontWeight.w600),
                                      ),
                                    );
                                  } else {
                                    final userData = snapshot.data as ProfileRes?;
                                    if (userData != null) {
                                      return SizedBox(
                                        height: 35.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: userData.username,
                                              style: appstyle(14, Colors.black, FontWeight.normal),
                                            ),
                                            ReusableText(
                                              text: userData.email,
                                              style: appstyle(9, Colors.grey, FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: ReusableText(
                                          text: "User data is null",
                                          style: appstyle(18, Colors.black, FontWeight.w600),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),



                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(

                                child: Icon(Feather.edit, size: 18)
                            ),
                          )

                        ],
                      ),

                    )

                  ],
                ),
              ),
              Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 160.h,
                        color: Colors.grey.shade200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TilesWidget(
                                  OnTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (
                                            context) => const LoginPage()));
                                  },
                                  title: "My Orders",
                                  leading: MaterialCommunityIcons
                                      .truck_fast_outline),
                              TilesWidget(
                                  OnTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (
                                            context) => const Favorites()));
                                  },
                                  title: "My Favorites",
                                  leading: MaterialCommunityIcons
                                      .heart_outline),
                              TilesWidget(
                                  OnTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => CartPage()));
                                  },
                                  title: "My Cart",
                                  leading: Fontisto.shopping_bag),
                            ]

                        )
                    ),
                    SizedBox(
                      height: 10,

                    ),
                    Container(
                        height: 110.h,
                        color: Colors.grey.shade200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TilesWidget(
                                  OnTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                  },
                                  title: "My Store",
                                  leading: MaterialCommunityIcons
                                      .shopping_outline),
                              TilesWidget(
                                  OnTap: () {
                                    authNotifier.logout();
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (
                                            context) => const LoginPage()));
                                  },
                                  title: "Logout",
                                  leading: AntDesign.logout),
                            ]

                        )
                    ),
                    SizedBox(
                      height: 10,

                    ),

                  ]

              )

            ],
          )
          ,
        ));
  }
}




