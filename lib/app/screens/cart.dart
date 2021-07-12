import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/empty_cart.dart';
import 'package:shop_app/app/screens/full_cart.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List product=[];
    return product.isNotEmpty?EmptyCart():FullCartScreen();
  }
}