import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/feeds.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/bottom_navgation_bar.dart';
import 'package:shop_app/const/theme.dart';
import 'package:shop_app/inner_screens/brands_navigation_rail.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider=DarkThemeProvider(); 
  void getCurrentAppTheme() async{
    //here assign the theme status in darkThemePreferences class to the themeChangeProvider to notify the all app
    //and if the user close the app and open it again,he show the same theme that he choose it
    themeChangeProvider.darkTheme=await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (_){return themeChangeProvider;})],
    //consumer as same as provider but this for only one widget
    child: Consumer<DarkThemeProvider>(
      builder: (context, themeData,child){
        return  MaterialApp(
        title: 'Shope App',
        theme:Styles.themeData(themeChangeProvider.darkTheme, context) ,
        home:BottomBarPage(),
        routes: {
              //   '/': (ctx) => LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartPage.routeName: (ctx) => CartPage(),
              FeedsPage.routeName: (ctx) => FeedsPage(),
              WishlistPage.routeName: (ctx) => WishlistPage(),
              ProductDetailsPage.routeName:(ctx)=> ProductDetailsPage(),
            },
      );

      }
      
    ),);
  }
}
// ThemeData(
//         primarySwatch: Colors.teal,
//         primaryColor: Colors.white,
//         disabledColor: Colors.black.withOpacity(0.7), 
//         splashColor: Colors.cyan.withOpacity(0.2),
        
//       )

