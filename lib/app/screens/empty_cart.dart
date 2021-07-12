import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/provider/dart_theme_provider.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeChange=Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/emptycart.png"))),
          ),
        
          Text(
            "Your cart is empty!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 35,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30,),
          Text(
            "looks like you didn\'t add anything to your cart",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {},
            child: Text(
                          "Shopping Time",
                          style: TextStyle(color: Colors.brown[600], fontSize: 22,letterSpacing: 1,decoration: TextDecoration.underline,fontFamily: "KiwiMaru"),
                        ),
          )
        ],
      ),
    );
  }
}
