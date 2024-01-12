

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/views/shared/custom_field.dart';
import 'package:online_shop/views/shared/reusable_text.dart';
import 'package:online_shop/views/ui/product_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(
          hintText: 'Search for a product',
          controller: search,
          onEditingComplete: () {
            setState(() {

            });
          },
          prefixIcon: GestureDetector(
            onTap: (){},
            child: Icon(AntDesign.camera, color: Colors.black),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {

              });
            },
            child: Icon(AntDesign.search1, color: Colors.black),
          ),
        ),
      ),
      body: search.text.isEmpty
          ? Container(
              height: 600,
              padding: EdgeInsets.all(20.h),
              margin: EdgeInsets.only(right: 50.w),
              child: Image.asset('assets/images/Pose23.png'),
      )
          : FutureBuilder<List<Sneakers>>(
          future: Helper().search(search.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }else if (snapshot.hasError){
              return Center(
                child: ReusableText(text: 'Error retriving the data',
                style: appstyle(20, Colors.black, FontWeight.bold)),
              );
            }else if (snapshot.data!.isEmpty) {
              return Center(
                child: ReusableText(text: 'Product not found',
                    style: appstyle(20, Colors.black, FontWeight.bold)),
              );
            }else {
              final shoes = snapshot.data;
              return ListView.builder(
                itemCount: shoes!.length,
                itemBuilder: ((context, index){
                  final shoe = shoes[index];
                  return GestureDetector(
                    onTap: () {

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>
                                  ProductPage(sneakers: shoe)));
                    },
                    child: Padding(padding: EdgeInsets.all(8.h),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 100.h,
                        width: 325,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 5,
                              blurRadius: 0.3,
                              offset: const Offset(0, 1)
                          )
                          ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.all(12.h),
                      child: CachedNetworkImage(
                        imageUrl: shoe.imageUrl[0],
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover
                  )
                  ),
                      Padding(padding: EdgeInsets.only(top: 12, left: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                      )

                  ]
                          ),
                  )

                  )
                  ));

              })
              );
            }
          }

      )
      );

  }
}