import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Services/constants.dart';
import '../../../Services/globle.dart';
import '../../../models/Product.dart';

class FavIcon extends StatelessWidget {
  const FavIcon( this.product) ;

  final Product product;

  @override
  Widget build(BuildContext context) {
    print(Globle.isfav);
    print(Globle.projectid);
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Globle.isfav == true && Globle.projectid==product.id? kMainDarkColor : kTextColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Globle.isfav == true && Globle.projectid==product.id? kMainDarkColor : kTextColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset(
          "assets/icons/heart.svg",
        ),
      ),
    );
  }
}
