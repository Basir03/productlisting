import 'package:flutter/material.dart';
import 'package:productlisting/View/details/components/sizes.dart';

import '../../../models/Product.dart';

import '../../../Services/constants.dart';
import 'cart_counter.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body(this.product, {super.key});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            productInfo( "category" , product.category.toString()),
                            const SizedBox(height: kDefaultPaddin / 2),
                            productInfo( "ID",  product.id.toString()),
                            const SizedBox(height: kDefaultPaddin / 2),
                            productInfo( "Rating", product.rating.rate.toString()),
                            const SizedBox(height: kDefaultPaddin / 2),

                          ],
                        ),
                        Expanded(
                          child: Hero(
                            tag: "${product.id}",
                            child: Image.network(
                              product.image.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPaddin,
              right: kDefaultPaddin,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: kDefaultPaddin / 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Text(
                            "\$${product.price! + 100}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: kMainDarkColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            "  \$${product.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPaddin / 2),
                const Sizes(),
                const SizedBox(height: kDefaultPaddin / 2),
                Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "About",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )),
                  const SizedBox(height: kDefaultPaddin / 5),
                  Text(
                    product.description.toString(),
                    style: const TextStyle(height: 1.5),
                  ),
                ],
              ),
                const SizedBox(height: kDefaultPaddin / 2),
                Row(
                  children: [
                    const CartCounter(),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: kMainDarkColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "ADD TO CART".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPaddin / 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class productInfo extends StatelessWidget {
  const productInfo(this.product, this.title, {super.key} );

  final String product;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF8B2833),
          ),
        ),
        Text(
          product,
          style: TextStyle(
            color: const Color(0xFF8B2833).withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
