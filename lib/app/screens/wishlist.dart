import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/empty_wishlist.dart';
import 'package:shop_app/app/screens/full_wishlist.dart';

class WishlistPage extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishlistList = [];
    return wishlistList.isNotEmpty
        ? EmptyWishlist()
        : Scaffold(
          appBar: AppBar( flexibleSpace: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.teal,
                Colors.teal.withOpacity(0.5),
              ]))),
          elevation: 5,
          title: Text("Wishlist"),
         ),
            body: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8),
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return FullWishlist();
                  }),
            ));
  }
}
