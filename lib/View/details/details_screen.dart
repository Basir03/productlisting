import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productlisting/screens/details/components/body.dart';

import '../../constants.dart';
import '../../models/Product.dart';


class DetailsScreen extends StatelessWidget {
  final Product? product;

  const DetailsScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(product!),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kMainColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        // FavIcon(product),
        const SizedBox(width: kDefaultPaddin)
      ],
    );
  }
}
