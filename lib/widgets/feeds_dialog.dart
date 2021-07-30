import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/const/my_icons.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/provider/wishlist_provider.dart';

class FeedsDialog extends StatelessWidget {
  const FeedsDialog({Key? key, required this.productId}) : super(key: key);
  final String productId;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);

    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<WishListProvider>(context);
    final prodAttr = productsData.findById(productId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.4),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.network(
                prodAttr.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Flexible(
                        child: dialogContent(
                            context,
                            0,
                            favProvider.getWishListItems.containsKey(productId)
                          ? () {}
                          : () {
                              favProvider.addAndRemoveFav(
                                  productId,
                                  prodAttr.title,
                                  prodAttr.price,
                                  prodAttr.imageUrl);
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },)),
                    Flexible(
                        child: dialogContent(
                            context,
                            1,
                            () => {
                                  Navigator.pushNamed(
                                          context, ProductDetailsPage.routeName,
                                          arguments: prodAttr.id)
                                      .then((value) => Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null)
                                })),
                    Flexible(
                        child: dialogContent(
                            context,
                            2,
                            
                            cartProvider.getCartItems.containsKey(productId)
                          ? () {}
                          : () {
                              cartProvider.addProdToCart(
                                  productId,
                                  prodAttr.title,
                                  prodAttr.price,
                                  prodAttr.imageUrl);
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                                  
                                )
                     ) ],
                )),
            /*********Close*********/
            Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.3)),
                    child:  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        splashColor: Colors.grey,
                        onTap: (){Navigator.canPop(context)?Navigator.pop(context):null;},
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(Icons.close, size: 28, color: Colors.red)),
                      ),
                    ),)
          ],
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, VoidCallback fct) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<WishListProvider>(context);
    List<IconData> _dialogIcons = [
      favProvider.getWishListItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Entypo.eye,
      MyAppIcons.cart,
    ];
    List<String> _texts = [
      favProvider.getWishListItems.containsKey(productId)
          ? "In wishlist"
          : "Add to wishlist",
      "View product",
      cartProvider.getCartItems.containsKey(productId)
          ? "In cart"
          : "Add to cart",
    ];
    List<Color> _colors = [
      favProvider.getWishListItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
    ];
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FittedBox(
                    child: Text(
                      _texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        //  fontSize: 15,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
