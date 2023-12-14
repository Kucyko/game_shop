import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/views/shared/stagger_tile.dart';

class latestShoes extends StatelessWidget {
  const latestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(3.0),
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 20,
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.extent(
                        (index % 2 == 0) ? 1 : 1,
                        (index % 4 == 1 || index % 4 == 3)
                            ? MediaQuery.of(context).size.height *
                                0.26    // Ulozenie kafelkow
                            : MediaQuery.of(context).size.height *
                                0.26),
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggerTile(
                      imageUrl: shoe.imageUrl[0],
                      name: shoe.name,
                      price: "\$${shoe.price}");
                });
          }
        });
  }
}
