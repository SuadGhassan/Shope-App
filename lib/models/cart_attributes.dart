import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartAttr with ChangeNotifier{
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartAttr( {required this.id, required this.title,required this.imageUrl, required this.price, required this.quantity});
}