import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/const/my_icons.dart';
import 'package:shop_app/models/feeds_products.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",style:TextStyle(color:themeState.darkTheme?Colors.white70:Colors.black)),
        elevation: 10,
        flexibleSpace: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.teal,
              Colors.teal.withOpacity(0.9),
            ]))),
            actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      MyAppIcons.wishlist,
                      color: themeState.darkTheme?Colors.white70:Colors.black26,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(WishlistPage.routeName);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      MyAppIcons.cart,
                      color: themeState.darkTheme?Colors.white70:Colors.black26,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartPage.routeName);
                    },
                  ),
                ]
      ),
      body: Stack(children: [
        Container(
          foregroundDecoration: BoxDecoration(color: Colors.black12),
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU',
            fit: BoxFit.fill,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16,right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.purple.shade200,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.save,
                            size: 25,
                            color: Color(0xFFBA993A),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.purple.shade200,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share,
                            size: 25,
                            color: Color(0xFFBA993A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                //padding: const EdgeInsets.all(16.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              'Title',
                              maxLines: 2,
                              style: TextStyle(
                                // color: Theme.of(context).textSelectionColor,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'US \$ 15',
                            style: TextStyle(
                                color: themeState.darkTheme
                                    ? Theme.of(context).disabledColor
                                    : Color(0xFFBA993A),
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 3.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 21.0,
                          color: themeState.darkTheme
                              ? Theme.of(context).disabledColor
                              : Color(0xFFBA993A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                    _details(themeState.darkTheme, 'Brand: ', 'BrandName'),
                    _details(themeState.darkTheme, 'Quantity: ', '12 Left'),
                    _details(themeState.darkTheme, 'Category: ', 'Cat Name'),
                    _details(themeState.darkTheme, 'Popularity: ', 'Popular'),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                      height: 1,
                    ),

                    // const SizedBox(height: 15.0),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No reviews yet',
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Be the first review!',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                color: themeState.darkTheme
                                    ? Theme.of(context).cardColor
                                    : Color(0xFFBA993A),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(children: [ Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20,),
                // Container(
                //   margin: EdgeInsets.only(bottom: 30),
                //   width: double.infinity,
                //  height: 300,
                //   child: ListView.builder(
                //     itemCount: 7,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext ctx, int index) {
                //       return ProductCard();
                //     },
                //   ),
                // ),
                ],),
            ],
          ),
        ),
         Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: ElevatedButton(

                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // shape: RoundedRectangleBorder(side: BorderSide.none),
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFBA993A))),
                      onPressed: () {},
                      child: Text(
                        'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // shape: RoundedRectangleBorder(side: BorderSide.none),
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textSelectionColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Color(0xFFBA993A),
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color:  Color(0xFFBA993A),
                    height: 50,
                    child: InkWell(
                      splashColor: Colors.red,
                      onTap: () {},
                      child: Center(
                        child: Icon(
                          MyAppIcons.wishlist,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
      
      ]),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState?Colors.white70:Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
