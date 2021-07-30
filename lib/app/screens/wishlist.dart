import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/empty_wishlist.dart';
import 'package:shop_app/widgets/full_wishlist.dart';
import 'package:shop_app/models/wishlist_attr.dart';
import 'package:shop_app/provider/wishlist_provider.dart';
import 'package:shop_app/services/show_dialog.dart';


class WishlistPage extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider=Provider.of<WishListProvider>(context);
    ShowDialog showDialogObj=ShowDialog();
    return favProvider.getWishListItems.isEmpty
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
          title: Text("Wishlist (${favProvider.getWishListItems.length})"),
           actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap:(){showDialogObj.showDialoggg('Clear Wishlist!',
                                  'Your wishlist will be cleared!',()=> favProvider.clearWishList(), context);
                      },
                    child: Icon(Icons.delete
                    ,color:Colors.cyan[900])),
                )
              ],
         ),
            body: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8),
              child: ListView.builder(
                  itemCount:favProvider.getWishListItems.length ,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value:favProvider.getWishListItems.values.toList()[index],
                      child: FullWishlist(productId:favProvider.getWishListItems.keys.toList()[index],),);
                  }),
            ));
  }
}
