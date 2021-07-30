import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/wishlist_provider.dart';


class PopularProducts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
        final productBrandAttributes=Provider.of<Product>(context);
         final cartProvider = Provider.of<CartProvider>(context);
final favProvider = Provider.of<WishListProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
           borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),),
                  onTap: () { Navigator.pushNamed(context, ProductDetailsPage.routeName,arguments:productBrandAttributes.id );},

            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height:170,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    productBrandAttributes.imageUrl,),
                                fit: BoxFit.contain)),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star,
                        color: favProvider.getWishListItems.containsKey(productBrandAttributes.id)?Colors.red[900]:Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Entypo.star_empty,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '${productBrandAttributes.price} SR',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productBrandAttributes.title,
                        maxLines: 1,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex:5,
                            child: Text(
                             productBrandAttributes.desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex:1,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {cartProvider.getCartItems.containsKey(productBrandAttributes.id)?(){}:
                      cartProvider.addProdToCart(
                          productBrandAttributes.id,
                          productBrandAttributes.title,
                          productBrandAttributes.price,
                          productBrandAttributes.imageUrl);},
                                borderRadius: BorderRadius.circular(30.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(right:16.0),
                                  child:
                                    Icon(cartProvider.getCartItems.containsKey(productBrandAttributes.id)?Icons.check:
                                     Icons.add,
                                      size: 28,
                                      color: Colors.cyan[900],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}