import 'package:flutter/material.dart';
import 'package:online_shop/controllers/mainscreen_provider.dart';
import 'package:online_shop/views/shared/bottom_nav.dart';
import 'package:online_shop/views/ui/cartpage.dart';
import 'package:online_shop/views/ui/favorites.dart';
import 'package:online_shop/views/ui/homepage.dart';
import 'package:online_shop/views/ui/nonuser.dart';
import 'package:online_shop/views/ui/profile.dart';
import 'package:online_shop/views/ui/searchpage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList =  [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    const NonUser()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),

          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottoNavBar(),
        );
      },
    );
  }
}
