import 'package:flutter/material.dart';
import 'package:shop_app/models/wishlist_attr.dart';

class WishListProvider with ChangeNotifier{
   Map<String, WishListAttr> _wishListItems = {};

  Map<String, WishListAttr> get getWishListItems {
    return {..._wishListItems};
  }

  void addAndRemoveFav(
       String productId, String title, double price, String imageUrl) {
        //check if the product already in the Cart just increase the quantity by one
    if (_wishListItems.containsKey(productId)) {
     removeProductFromWish(productId);
    }
    //else here means add the item to the cart
    else{
       _wishListItems.putIfAbsent(
          productId,
           ()=>WishListAttr (
             id: DateTime.now().toString(),
             title: title,
             imageUrl: imageUrl,
             price: price,
             ));

    }
    notifyListeners();
  }

  //Remove//
  void removeProductFromWish(String productId){
    _wishListItems.remove(productId);
    notifyListeners();
  }

  //Clear//
  void clearWishList(){
    _wishListItems.clear();
    notifyListeners();
  }
}