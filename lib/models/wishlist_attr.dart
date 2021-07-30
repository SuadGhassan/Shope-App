import 'package:flutter/material.dart';

class WishListAttr with ChangeNotifier{
  final String id;
  final String imageUrl;
  final String title;
  final double price;

  WishListAttr( {required this.id, required this.imageUrl, required this.title, required this.price});
}