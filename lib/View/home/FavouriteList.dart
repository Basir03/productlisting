import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productlisting/models/Product.dart';

import '../../../Controller/productList.dart';
import '../../Services/constants.dart';
import '../../Services/globle.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  final productList _productController = productList();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text('Favorite Item',style: TextStyle(color: kMainDarkColor),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin,
                vertical: kDefaultPaddin / 2,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List<Product>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(
                        color: kMainDarkColor,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No products available.');
                    } else {
                      List<Product> products = snapshot.data!;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Globle.isfav == true &&
                                Globle.projectid ==
                                    products[index].id ? Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(
                                            kDefaultPaddin / 2),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: kTextColor,
                                              spreadRadius: 0.1,
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Globle.isfav == true &&
                                                      Globle.projectid ==
                                                          products[index].id
                                                      ? kMainDarkColor
                                                      : kTextColor,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Globle.isfav == true &&
                                                          Globle.projectid == products[index].id
                                                          ? kMainDarkColor
                                                          : kTextColor,
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/heart.svg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 50,),
                                            SizedBox(
                                              height: 125,
                                              child: Hero(
                                                tag: "${products[index].id}",
                                                child: Image.network(
                                                    products[index]
                                                        .image
                                                        .toString()),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          kDefaultPaddin / 2),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    products[index]
                                                        .title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ):const SizedBox.shrink();
                          });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
