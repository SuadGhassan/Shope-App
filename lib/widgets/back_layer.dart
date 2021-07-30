import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/feeds.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/const/my_icons.dart';
import 'package:shop_app/widgets/upload_new_product.dart';

class BackLayer extends StatelessWidget {
   BackLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.teal,
                    Colors.teal.withOpacity(0.5),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Positioned(
            top: -100.0,
            left: 140.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 250,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 100.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: -50.0,
            left: 50.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: Transform.rotate(
              angle: -0.8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                width: 150,
                height: 200,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10.0)),
                           child: Container(
                      //   clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                            fit: BoxFit.fill,
                          )),
                    ),
                    ),
                  ),
                   const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, FeedsPage.routeName);
                }, 'Feeds', 0,Theme.of(context).disabledColor),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, CartPage.routeName);
                }, 'Cart', 1,Theme.of(context).disabledColor),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, WishlistPage.routeName);
                }, 'Wishlist', 2,Theme.of(context).disabledColor),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, UploadProduct.routeName);
                }, 'Upload a new product', 3,Theme.of(context).disabledColor),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
    List _contentIcons = [
    MyAppIcons.rss,
    MyAppIcons.bag,
    MyAppIcons.wishlist,
    MyAppIcons.upload
  ];
  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

  Widget content(BuildContext ctx,  VoidCallback fct, String text, int index,Color color) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700,color:color),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index],color: color,)
        ],
      ),
    );
  }
}
