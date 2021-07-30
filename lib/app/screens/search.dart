import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/widgets/feeds_products.dart';
import 'package:shop_app/widgets/search_by_header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<Product> _searchList = [];
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsList = productsData.products;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
           floating: true,
            pinned: true, //this imprtant to make the appBar shrink and still appear
          delegate: SearchByHeader(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ]),
              ),
              stackChild: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 3, spreadRadius: 1)
                    ]),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextController.text.isEmpty
                          ? null
                          : () {
                              _searchTextController.clear();
                              _node.unfocus();
                            },
                      icon: Icon(
                        Icons.close,
                        color: _searchTextController.text.isNotEmpty
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextController.text.toLowerCase();
                    setState(() {
                      _searchList = productsData.searchQuery(value);
                    });
                  },
                ),
              )),
        ),
        SliverToBoxAdapter(
            child: _searchTextController.text.isNotEmpty && _searchList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.search,
                        size:60,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text("No result found!",style:TextStyle(fontSize: 23))
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 300 / 600,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                        _searchTextController.text.isEmpty
                            ? productsList.length
                            : _searchList.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController.text.isEmpty
                            ? productsList[index]
                            : _searchList[index],
                        child: ProductCard(),
                      );
                    }),
                  ),),
      ],
    ));
  }
}
