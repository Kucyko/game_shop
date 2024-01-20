import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/controllers/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/checkout_btn.dart';
import 'package:online_shop/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_provider.dart';
import 'nonuser.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.sneakers});

  final Sneakers sneakers;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');



  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }





  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(

        resizeToAvoidBottomInset: false,
        body: Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      productNotifier.shoeSizes.clear();
                    },
                    child: const Icon(
                      AntDesign.close,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: const Icon(
                      Ionicons.ellipsis_horizontal,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            pinned: true,
            snap: false,
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height:
                    MediaQuery.of(context).size.height * 0.5,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sneakers.imageUrl.length,
                        controller: pageController,
                        onPageChanged: (page) {
                          productNotifier.activePage = page;
                        },
                        itemBuilder: (context, int index) {
                          return Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.39,
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                color: Colors.grey.shade300,
                                child: CachedNetworkImage(
                                  imageUrl:
                                  widget.sneakers.imageUrl[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.8,
                                  right: 20,
                                  child: const Icon(
                                    AntDesign.hearto,
                                    color: Colors.grey,
                                  )),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children:
                                    List<Widget>.generate(
                                        widget.sneakers
                                            .imageUrl.length,
                                            (index) => Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              4),
                                          child:
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor: productNotifier
                                                .activepage !=
                                                index
                                                ? Colors
                                                .grey
                                                : Colors
                                                .black,
                                          ),
                                        )),
                                  )),
                            ],
                          );
                        }),
                  ),
                  Positioned(
                      bottom: 30,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height *
                              0.7,
                          width:
                          MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.sneakers.name,
                                  style: appstyle(
                                      30,
                                      Colors.black,
                                      FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.sneakers.category,
                                      style: appstyle(
                                          20,
                                          Colors.grey,
                                          FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemPadding:
                                      const EdgeInsets
                                          .symmetric(
                                          horizontal: 1),
                                      itemBuilder: (context, _) =>
                                      const Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "\$${widget.sneakers.price}",
                                      style: appstyle(
                                          26,
                                          Colors.black,
                                          FontWeight.w600),
                                    ),


                                  ],
                                ),
                                const SizedBox(
                                  height: 1,
                                ),

                                const SizedBox(
                                  height: 1,
                                ),
                                const Divider(
                                  indent: 1,
                                  endIndent: 1,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),


                                Text(
                                  widget.sneakers.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 12,
                                  style: appstyle(
                                      14,
                                      Colors.black,
                                      FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment:
                                  Alignment.bottomCenter,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        top: 12),
                                    child: CheckoutButton(
                                      onTap: () async {
                                        if (authNotifier.loggeIn == true) {

                                        }
                                        else {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                                        }
                                      },
                                      label: "Add to Cart",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      );
    },
    )
  );
  }
}
