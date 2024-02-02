import 'package:flutter/material.dart';
import 'package:productlisting/models/Product.dart';


import '../../../Controller/productList.dart';
import '../../../constants.dart';

import '../../details/details_screen.dart';
import 'item_card.dart';
import 'item_card_v2.dart';

class Body extends StatefulWidget {
  const Body({super.key}) ;

  @override
  State<Body> createState() => _BodyState();
}


class _BodyState extends State<Body> {
  final productList _productController = productList();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: SingleChildScrollView(
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
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No products available.');
                    } else {
                      List<Product> products = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (context, index) => GestureDetector(
                          child: ItemCard(
                             products[index],
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                               products[index],
                            ),
                            ));
                          },
                        ),
                      );
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

