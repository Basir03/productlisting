import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productlisting/Services/globle.dart';

import '../../../Services/constants.dart';
import '../../../models/Product.dart';
import 'favIcon.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  // final Function press;
  const ItemCard(this.product, {super.key}) ;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(kDefaultPaddin / 2),
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    SizedBox(
                      height: 125,
                      child: Hero(
                        tag: "${widget.product.id}",
                        child: Image.network(widget.product.image.toString()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPaddin / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.title.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/Star.svg",
                                    color: const Color(0xFFEEA939),
                                    height: 10,
                                  ),
                                  Text(
                                   '${widget.product.rating.rate}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "\$ ${widget.product.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(top: 15, right: 15, child: GestureDetector(
            onTap: (){

              if(Globle.isfav==true){
                Globle.isfav=false;
                Globle.projectid=0;
              }else{
                Globle.isfav=true;
                Globle.projectid=widget.product.id;
              }
              setState(() {

              });
            },
            child: FavIcon(widget.product))),
      ],
    );
  }
}
