import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/screens/auth/forget_password.dart';
import 'package:shop_app/app/screens/auth/login.dart';
import 'package:shop_app/app/screens/auth/sign_up.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/feeds.dart';
import 'package:shop_app/app/screens/home.dart';
import 'package:shop_app/app/screens/landing_page.dart';
import 'package:shop_app/app/screens/Page_view_screens.dart';
import 'package:shop_app/app/screens/user_state.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/bottom_navgation_bar.dart';
import 'package:shop_app/const/theme.dart';
import 'package:shop_app/inner_screens/brands_navigation_rail.dart';
import 'package:shop_app/inner_screens/categories_feeds.dart';
import 'package:shop_app/inner_screens/product_details.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/provider/wishlist_provider.dart';
import 'package:shop_app/app/screens/upload_new_product.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //for Firebase
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    //here assign the theme status in darkThemePreferences class to the themeChangeProvider to notify the all app
    //and if the user close the app and open it again,he show the same theme that he choose it
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
 //this imporatnt beacuse i use the version 2.4.0 after 2.0.0 and this to make the app more smooth and better.//
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future:_initialization,
      builder: (context,snapShot) {
        if(snapShot.connectionState==ConnectionState.waiting){
          return MaterialApp(
            home:Scaffold(
              body: Center(child:CircularProgressIndicator()),
            )
          );
        }
        else if (snapShot.hasError){
          return MaterialApp(
            home:Scaffold(
              body: Center(child:Text("Error occured")),
            )
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return themeChangeProvider;
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return Products();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return CartProvider();
              },
            ),
            ChangeNotifierProvider(
              create: (_) {
                return WishListProvider();
              },
            ),
          ],
          //consumer as same as provider but this for only one widget
          child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
            return MaterialApp(
              title: ' Shop App',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: UserState(),
              routes: {
                // LandingPage.routeName: (ctx) => LandingPage(),
                // MainScreen.routeName:(ctx)=> MainScreen(),
                HomePage.routeName: (ctx) => HomePage(),
                BrandNavigationRailScreen.routeName: (ctx) =>
                    BrandNavigationRailScreen(),
                CartPage.routeName: (ctx) => CartPage(),
                FeedsPage.routeName: (ctx) => FeedsPage(),
                WishlistPage.routeName: (ctx) => WishlistPage(),
                ProductDetailsPage.routeName: (ctx) => ProductDetailsPage(),
                CategoriesFeeds.routeName: (ctx) => CategoriesFeeds(),
                LoginScreen.routeName: (ctx) => LoginScreen(),
                SignUp.routeName: (ctx) => SignUp(),
                BottomBarPage.routeName: (ctx) => BottomBarPage(),
                UploadProduct.routeName: (ctx) => UploadProduct(),
                ForgetPassword.routeName: (ctx) => ForgetPassword()
              },
            );
          }),
        );
      }
    );
  }
}
