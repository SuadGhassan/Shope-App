import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/const/my_icons.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/widgets/feeds_products.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/provider/wishlist_provider.dart';

class FeedsPage extends StatelessWidget {
  static const routeName = '/FeedsScreen';
  // const FeedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments;
    final productProvider = Provider.of<Products>(context);
    List<Product> productsList = productProvider.products;
    if (popular == "popular") {
      productsList = productProvider.PopularProducts;

      print(productsList);
    } else {
      productsList = productProvider.products;

      print(productsList);
    }
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text("Products"),
          elevation: 10,
          flexibleSpace: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.teal,
                Colors.teal.withOpacity(0.5),
              ]))),
          actions: <Widget>[
            Consumer<WishListProvider>(
              builder: (_, favs, child) => Badge(
                badgeColor: Color(0xFFBA993A),
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 3),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(favs.getWishListItems.length.toString(),
                    style: TextStyle(color: Colors.white)),
                child: IconButton(
                  icon: Icon(
                    MyAppIcons.wishlist,
                    color: themeState.darkTheme
                        ? Colors.white70
                        : Colors.cyan[900],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistPage.routeName);
                  },
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (_, cart, child) => Badge(
                badgeColor: Color(0xFFBA993A),
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 13),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(cart.getCartItems.length.toString(),
                    style: TextStyle(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(
                      MyAppIcons.cart,
                      color: themeState.darkTheme
                          ? Colors.white70
                          : Colors.cyan[900],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartPage.routeName);
                    },
                  ),
                ),
              ),
            ),
          ]),
      body: GridView.count(
        childAspectRatio: 300 / 600,
        mainAxisSpacing: 8,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        children: List.generate(
            productsList.length,
            (index) => ChangeNotifierProvider.value(
                value: productsList[index], child: ProductCard())),
      ),
    );
  }
}
