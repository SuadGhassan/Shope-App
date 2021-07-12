import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:shop_app/inner_screens/brands_navigation_rail.dart';
import 'package:shop_app/models/back_layer.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/popular_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerModel> listBanners = [
    BannerModel(
      id: "1",
      imagePath: 'assets/images/carousel1.png',
      boxFit: BoxFit.cover,
    ),
    BannerModel(
      id: "2",
      imagePath: 'assets/images/carousel2.jpeg',
      boxFit: BoxFit.cover,
    ),
    BannerModel(
      id: "3",
      imagePath: 'assets/images/carousel3.jpg',
      boxFit: BoxFit.cover,
    ),
    BannerModel(
      id: "4",
      imagePath: 'assets/images/carousel4.png',
      boxFit: BoxFit.cover,
    ),
  ];
  List swipperImageList = [
    'assets/images/samsung.jpg',
    'assets/images/nike.jpg',
    'assets/images/Huawei.jpg',
    'assets/images/h&m.jpg',
    'assets/images/Dell.jpg',
    'assets/images/apple.jpg',
    'assets/images/addidas.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BackdropScaffold(
          frontLayerBackgroundColor:Theme.of(context).scaffoldBackgroundColor,
          backLayerBackgroundColor:Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            elevation: 10,
            flexibleSpace: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.teal,
                  Colors.teal.withOpacity(0.5),
                ]))),
            title: Text("Home"),
            leading: BackdropToggleButton(
                icon: AnimatedIcons.menu_home,
                color: Theme.of(context).disabledColor),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  iconSize: 15,
                  icon: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                  ),
                ),
              )
            ],
          ),
          backLayer: BackLayer(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.2),
                  child: BannerCarousel.fullScreen(
                    banners: listBanners,
                    customizedIndicators: IndicatorModel.animation(
                        width: 15,
                        height: 5,
                        spaceBetween: 3,
                        widthAnimation: 20),
                    height: 180,
                    activeColor: Colors.amberAccent,
                    disableColor: Colors.white,
                    animation: false,
                    borderRadius: 10,

                    // width:double.maxFinite,
                    indicatorBottom: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Categories",
                  
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                ),
                           Container(
                             height: 180,
                             width: double.infinity,
                             child: ListView.builder(
                                                   itemCount: 6,
                                                   scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                                   return  Category(index: index);
                                                 }),
                           ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Popular Brands",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      Spacer(),
                      TextButton(
                        onPressed: () {Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            7,
                          },
                        );},
                        child: Text("View all...",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.red)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Swiper(
                    itemCount: swipperImageList.length,
                    autoplay: true,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    onTap: (index) {Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            index,
                          },
                        );},
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              color: Colors.blueGrey,
                              child: Image.asset(
                                swipperImageList[index],
                                fit: BoxFit.fill,
                              )));
                    },
                  ),
                ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Products',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                  TextButton(
                      onPressed: () { },
                      child: Text(
                        'View all...',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 285,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, int index) {
                      return PopularProducts();
                    }),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
