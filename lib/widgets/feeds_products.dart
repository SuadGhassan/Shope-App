import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/widgets/feeds_dialog.dart';

class ProductCard extends StatefulWidget {
  

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
      final productAttributes=Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsPage.routeName,
          arguments: productAttributes.id
          );
        },
        child: Container(
          // padding: EdgeInsets.all(8),
          width: 250,
          height:290,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Image.network(
                        productAttributes.imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ),
                  Badge(
                    toAnimate: true,
                    shape: BadgeShape.square,
                    badgeColor: Colors.pink.withOpacity(0.8),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                    badgeContent:
                        Text('New', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productAttributes.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        productAttributes.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity: ${productAttributes.quantity}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () async{showDialog(context: context, builder: (BuildContext context)=>FeedsDialog(productId:productAttributes.id,));},
                              borderRadius: BorderRadius.circular(18.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
