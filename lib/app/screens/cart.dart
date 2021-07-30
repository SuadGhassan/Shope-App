import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/empty_cart.dart';
import 'package:shop_app/widgets/full_cart.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/services/show_dialog.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/CartScreen';

  // const CartPage({Key? key}) : super(key: key);
  ShowDialog showDialogObj=ShowDialog();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: EmptyCart())
        : Scaffold(
            bottomSheet: checkoutSection(context),
            appBar: AppBar(
              flexibleSpace: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.teal,
                    Colors.teal.withOpacity(0.5),
                  ]))),
              elevation: 5,
              title: Text("My Cart (${cartProvider.getCartItems.length})"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap:(){showDialogObj.showDialoggg('Clear cart!',
                                  'Your cart will be cleared!',()=> cartProvider.clearCart(), context);
                      },
                    child: Icon(Icons.delete
                    ,color:Colors.cyan[900])),
                )
              ],
            ),
            body: Container(
                margin: EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value:cartProvider.getCartItems.values.toList()[index],
                        child: FullCartScreen(
                              productId: cartProvider.getCartItems.keys.toList()[index],
                        ),
                      );
                    })));
  }

  Widget checkoutSection(BuildContext context) {
        final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      //  decoration: BoxDecoration(border: BorderRadius.only()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red[900],
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total:',
              style: TextStyle(
                  // color: Theme.of(context).textSelectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '${cartProvider.totalAmount.toStringAsFixed(2)} SR',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.cyan[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
