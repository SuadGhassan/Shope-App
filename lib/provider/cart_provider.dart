import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProdToCart(
       String productId, String title, double price, String imageUrl) {
        //check if the product already in the Cart just increase the quantity by one
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartAttr(
              id:existingCartItem.id,
              title:existingCartItem.title,
             imageUrl: existingCartItem.imageUrl,
             price: existingCartItem.price,
            quantity:  existingCartItem.quantity + 1));
    }
    //else here means add the item to the cart
    else{
       _cartItems.putIfAbsent(
          productId,
           ()=> CartAttr(
             id: DateTime.now().toString(),
             title: title,
             imageUrl: imageUrl,
             price: price,
             quantity: 1));

    }
    notifyListeners();
  }

  //Reduse//
  void reduseCartItemByOne(String productId,String imageUrl,double price,String title){
if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartAttr(
              id:existingCartItem.id,
              title:existingCartItem.title,
             imageUrl: existingCartItem.imageUrl,
             price: existingCartItem.price,
            quantity:  existingCartItem.quantity - 1));
    }
    notifyListeners();
  }
  
  //Remove//
  void removeProductFromCart(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  //Clear//
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
