import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productlisting/View/details/components/body.dart';

import '../../Services/constants.dart';
import '../../models/Product.dart';


class DetailsScreen extends StatelessWidget {
  final Product? product;
  const DetailsScreen(this.product, {super.key});
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
      actions: const <Widget>[
        // FavIcon(product),
        SizedBox(width: kDefaultPaddin)
      ],
    );
  }
}
