
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/inner_screens/categories_feeds.dart';

class Category extends StatefulWidget {
   Category({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
List<Map<String,dynamic>> categoryList = [
    {'CatName': 'Beauty','CateImagePath': 'assets/images/CatBeauty.jpg',},
    {'CatName': 'Clothes', 'CateImagePath': 'assets/images/CatClothes.jpg'},
    {'CatName': 'Furnitures','CateImagePath': 'assets/images/CatFurniture.jpg'},
    {'CatName': 'Laptops', 'CateImagePath': 'assets/images/CatLaptops.png'},
    {'CatName': 'Phones', 'CateImagePath': 'assets/images/CatPhones.png'},
    {'CatName': 'Shoes','CateImagePath': 'assets/images/CatShoes.jpg',}
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(CategoriesFeeds.routeName,arguments:'${categoryList[widget.index]["CatName"]}');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage(categoryList[widget.index]['CateImagePath'],),
                fit: BoxFit.fill,
              )),
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 150,
          width: 150,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 10,
        right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
              color: Theme.of(context).cardColor,
              child: Text(
                categoryList[widget.index]['CatName'],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textSelectionColor),
              )))
    ]);
  }
}
