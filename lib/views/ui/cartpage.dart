import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/services/carthelper.dart';
import 'package:online_shop/views/shared/appstyle.dart';
import 'package:online_shop/views/shared/checkout_btn.dart';
import 'package:online_shop/views/ui/mainscreen.dart';
import 'package:online_shop/models/constants.dart';
import 'package:provider/provider.dart';

import '../../controllers/cart_provider.dart';
import '../../controllers/get_products.dart';
import '../shared/reusable_text.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),


                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.65,
                  child: FutureBuilder(
                    future: _cartList,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator.adaptive());
                      }else if (snapshot.hasError){
                        return Center(
                            child: ReusableText(text: "Failed to get cart data", style: appstyle(18, Colors.black, FontWeight.normal))
                        );

                      }else{
                        final cartData = snapshot.data;
                        return ListView.builder(
                          itemCount: cartData!.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = cartData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: doNothing,
                                        backgroundColor: const Color(0xFF000000),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.12,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 5,
                                              blurRadius: 0.3,
                                              offset: const Offset(0, 1)),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data.cartItem.imageUrl[0],
                                                width: 70,
                                                height: 50,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.cartItem.name,
                                                    style: appstyle(
                                                        13,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    data.cartItem.category,
                                                    style: appstyle(
                                                        14, Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data.cartItem.price,
                                                        style: appstyle(
                                                            18,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),


                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(16))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () async{
                                                          await CartHelper().deleteItem(data.id).then((response){
                                                            if(response == true) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          MainScreen()));
                                                            }else{
                                                              debugPrint("Failed to delete the item");
                                                            }

                                                          });

                                                        },
                                                        child: const Icon(
                                                          AntDesign.minussquare,
                                                          size: 25,
                                                          color: Colors.grey,
                                                        )),

                                                  ],
                                                ),
                                              ),
                                            ),

                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });}


                    }
                  ),
                )
              ],
            ),
            const Align(alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: "Proceed to Checkout"),),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}

}