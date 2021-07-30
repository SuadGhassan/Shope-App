import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/wishlist_attr.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/provider/wishlist_provider.dart';
import 'package:shop_app/services/show_dialog.dart';

class FullWishlist extends StatefulWidget {
  const FullWishlist({Key? key, required this.productId}) : super(key: key);
final String productId;
  @override
  _FullWishlistState createState() => _FullWishlistState();
}

class _FullWishlistState extends State<FullWishlist> {
  @override
  Widget build(BuildContext context) {
    final favAttrs = Provider.of<WishListAttr>(context);
    
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(favAttrs.imageUrl),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favAttrs.title,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            " ${favAttrs.price} SR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(widget.productId),
      ],
    );
  }

  Widget positionedRemove(String id) {
         final favProvider=Provider.of<WishListProvider>(context);
ShowDialog showDialogObj=ShowDialog();
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: Colors.red[800],
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed:(){showDialogObj.showDialoggg('Remove a Wish',
                                  'Your Wish product will be removed!', ()=>favProvider.removeProductFromWish(id), context);}
          
        ),
      ),
    );
  }
}
