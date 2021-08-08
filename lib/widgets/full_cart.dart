import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/models/cart_attributes.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/services/show_dialog.dart';

class FullCartScreen extends StatefulWidget {
  const FullCartScreen({Key? key, required this.productId}) : super(key: key);

  final String productId;

  @override
  State<FullCartScreen> createState() => _FullCartScreenState();
}

class _FullCartScreenState extends State<FullCartScreen> {
  ShowDialog showDialogObj=ShowDialog();
  @override
  Widget build(BuildContext context) {
      final cartProvider = Provider.of<CartProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetailsPage.routeName,
          arguments: widget.productId),
      child: Container(
        height: 130,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(15),
              bottomRight: const Radius.circular(15)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
                width: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          cartAttr.imageUrl,
                        ),
                        fit: BoxFit.contain
                        ))),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        cartAttr.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {showDialogObj.showDialoggg('Remove a product!',
                                  'Product will be removed from the cart!', ()=>cartProvider.removeProductFromCart(widget.productId),context);
                                },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red[900],
                                ),
                              )))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Price:"),
                      SizedBox(
                        width: 2,
                      ),
                      Text("${cartAttr.price} USD"),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text("Sub Total:"),
                      SizedBox(
                        width: 2,
                      ),
                      Text("${subTotal.toStringAsFixed(2)} USD"),
                    ],
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Text("Ships free:"),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: cartAttr.quantity<2?null:() {
                             cartProvider.reduseCartItemByOne(widget.productId,cartAttr.imageUrl,cartAttr.price, cartAttr.title);
                              
                              },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: cartAttr.quantity<2?Colors.green[700]:Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 12,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.teal,
                                Colors.teal.withOpacity(0.5),
                              ], stops: [
                                0.0,
                                0.7
                              ]),
                            ),
                            child: Text(
                              cartAttr.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            // splashColor: ,
                            onTap: () {cartProvider.addProdToCart(widget.productId,cartAttr.title,cartAttr.price,cartAttr.imageUrl);},
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green[700],
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
