import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/feeds_products.dart';
import 'package:shop_app/provider/products.dart';

class CategoriesFeeds extends StatefulWidget {
  static const routeName = '/CategoriesFeedsScreen';

  @override
  State<CategoriesFeeds> createState() => _CategoriesFeedsState();
}

class _CategoriesFeedsState extends State<CategoriesFeeds> {
// Future _getProductsOnRefresh(String name) async{
//   await Provider.of<Products>(context,listen: false).findProdByCatName(name);
//   setState(() {

//   });
// }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    // print(categoryName);
    final productsList = productProvider.findProdByCatName(categoryName);
    // print('productsList ${productsList[0].productCategoryName}');
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        elevation: 10,
        flexibleSpace: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.teal,
              Colors.teal.withOpacity(0.5),
            ]))),
      ),
      // body: StaggeredGridView.countBuilder(
      //     mainAxisSpacing: 8,
      // crossAxisSpacing: 5,
      // crossAxisCount: 6,
      // itemCount: _products.length,
      // itemBuilder: (BuildContext context, int index) =>ProductCard(
      //             id: _products[index].id,
      //             price: _products[index].price,
      //             imageURL: _products[index].imageUrl,
      //             desc: _products[index].desc,
      //             quantity: _products[index].quantity,
      //             isPupolar: _products[index].isPopular,
      //             isFaviorted: _products[index].isFaviorted,
      //           ) ,
      // staggeredTileBuilder: (int index) =>
      // new StaggeredTile.count(3, index.isEven ? 4 : 5),

      // ),
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
