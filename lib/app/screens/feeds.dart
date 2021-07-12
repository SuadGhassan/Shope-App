import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/feeds_products.dart';

class FeedsPage extends StatelessWidget {
  static const routeName = '/FeedsScreen';
  // const FeedsPage({Key? key}) : super(key: key);
  List<Product> _products = [
    Product(
        id: 'Samsung1',
        title: 'Samsung Galaxy S9',
        desc:
            'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 65,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Samsung Galaxy A10s',
        title: 'Samsung Galaxy A10s',
        desc:
            'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Samsung ',
        productCategoryName: 'Phones',
        quantity: 1002,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Samsung Galaxy A51',
        title: 'Samsung Galaxy A51',
        desc:
            'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        quantity: 6423,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Huawei P40 Pro',
        title: 'Huawei P40 Pro',
        desc:
            'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
        price: 900.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'iPhone 12 Pro',
        title: 'iPhone 12 Pro',
        desc:
            'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
        price: 1100,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 3,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'iPhone 12 Pro Max ',
        title: 'iPhone 12 Pro Max ',
        desc:
            'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        quantity: 2654,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Hanes Mens ',
        title: 'Long Sleeve Beefy Henley Shirt',
        desc: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategoryName: 'Clothes',
        quantity: 58466,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Weave Jogger',
        title: 'Weave Jogger',
        desc: 'Champion Mens Reverse Weave Jogger',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 84894,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Adeliber Dresses for Womens',
        title: 'Adeliber Dresses for Womens',
        desc:
            'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        quantity: 49847,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Tanjun Sneakers',
        title: 'Tanjun Sneakers',
        desc:
            'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        quantity: 65489,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Training Pant Female',
        title: 'Training Pant Female',
        desc: 'Nike Epic Training Pant Female ',
        price: 189.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61jvFw72OVL._AC_UX466_.jpg',
        brand: 'Nike',
        productCategoryName: 'Clothes',
        quantity: 89741,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Trefoil Tee',
        title: 'Trefoil Tee',
        desc: 'Originals Women\'s Trefoil Tee ',
        price: 88.88,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51KMhoElQcL._AC_UX466_.jpg',
        brand: 'Addidas',
        productCategoryName: 'Clothes',
        quantity: 8941,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Long SleeveWoman',
        title: 'Long Sleeve woman',
        desc: ' Boys\' Long Sleeve Cotton Jersey Hooded T-Shirt Tee',
        price: 68.29,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71lKAfQDUoL._AC_UX466_.jpg',
        brand: 'Addidas',
        productCategoryName: 'Clothes',
        quantity: 3,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Eye Cream for Wrinkles',
        title: 'Eye Cream for Wrinkles',
        desc:
            'Olay Ultimate Eye Cream for Wrinkles, Puffy Eyes + Dark Circles, 0.4 fl oz',
        price: 54.98,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61dwB-2X-6L._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        quantity: 8515,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Mango Body Yogurt',
        title: 'Mango Body Yogurt',
        desc:
            'The Body Shop Mango Body Yogurt, 48hr Moisturizer, 100% Vegan, 6.98 Fl.Oz',
        price: 80.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81w9cll2RmL._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        quantity: 3,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Food Intensive Skin',
        title: 'Food Intensive Skin',
        desc:
            'Weleda Skin Food Intensive Skin Nourishment Body Butter, 5 Fl Oz',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71E6h0kl3ZL._SL1500_.jpg',
        brand: 'No Brand',
        productCategoryName: 'Beauty & health',
        quantity: 38425,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Ultra Shea Body Cream',
        title: 'Ultra Shea Body Cream',
        desc:
            'Bath and Body Works IN THE STARS Ultra Shea Body Cream (Limited Edition) 8 Ounce ',
        price: 14,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61RkTTLRnNL._SL1134_.jpg',
        brand: '',
        productCategoryName: 'Beauty & health',
        quantity: 384,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Soft Moisturizing Crème',
        title: 'Soft Moisturizing Crème',
        desc:
            'NIVEA Soft Moisturizing Crème- Pack of 3, All-In-One Cream For Body, Face and Dry Hands - Use After Hand Washing - 6.8 oz. Jars',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/619pgKveCdL._SL1500_.jpg',
        brand: 'No Brand',
        productCategoryName: 'Beauty & health',
        quantity: 45,
        isPopular: true,
        isFaviorted: false),
    Product(
        id: 'Body Cream Cocoa Butter',
        title: 'Body Cream Cocoa Butter',
        desc: 'NIVEA Cocoa Butter Body Cream 15.5 Oz',
        price: 84.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61EsS5sSaCL._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        quantity: 98432,
        isPopular: true,
        isFaviorted: false),
    Product(
        id: 'Garmin Forerunner 45S',
        title: 'Garmin Forerunner 45S',
        desc:
            'Garmin Forerunner 45S, 39mm Easy-to-use GPS Running Watch with Coach Free Training Plan Support, Purple',
        price: 86.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51EWl3XsiYL._AC_SL1000_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        quantity: 142,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'Samsung Galaxy Watch Active 2',
        title: 'Samsung Galaxy Watch Active 2',
        desc:
            'Samsung Galaxy Watch Active 2 (40mm, GPS, Bluetooth) Smart Watch with Advanced Health Monitoring, Fitness Tracking , and Long Lasting Battery - Silver (US Version)',
        price: 300.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51bSW9gjoaL._AC_SL1024_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        quantity: 167,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'Garmin vivoactive 4S',
        title: 'Garmin vivoactive 4S',
        desc:
            'Garmin vivoactive 4S, Smaller-Sized GPS Smartwatch, Features Music, Body Energy Monitoring, Animated Workouts, Pulse Ox Sensors, Rose Gold with White Band',
        price: 40.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51r2LCE3FLL._AC_SL1000_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        quantity: 659,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'Patek Philippe World',
        title: 'Patek Philippe World',
        desc: 'Patek Philippe World Time Men\'s Watch Model 5131/1P-001',
        price: 20.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61MVdCYfbOL._AC_UX679_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        quantity: 98,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'Bell & Ross Men',
        title: 'Bell & Ross Men',
        desc:
            'Bell & Ross Men\'s BR-MNUTTOURB-PG Minuteur\' Black Carbon Fiber Dial 18K Rose Gold Tourbillon Watch',
        price: 33.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91M50AHRTKL._AC_UX569_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        quantity: 951,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'New Apple Watch Series',
        title: 'New Apple Watch Series',
        desc:
            'New Apple Watch Series 6 (GPS, 40mm) - Blue Aluminum Case with Deep Navy Sport Band ',
        price: 400.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71bf9IpGjtL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        quantity: 951,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'New Apple Watch SE',
        title: 'New Apple Watch SE',
        desc:
            'New Apple Watch SE (GPS, 40mm) - Gold Aluminum Case with Pink Sand Sport Band',
        price: 200.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71JtUMDeBBL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        quantity: 951,
        isPopular: false,
        isFaviorted: true),
    Product(
        id: 'YAMAY Smart Watch 2020 Ver',
        title: 'YAMAY Smart Watch 2020 Ver',
        desc:
            'YAMAY Smart Watch 2020 Ver. Watches for Men Women Fitness Tracker Blood Pressure Monitor Blood Oxygen Meter Heart Rate Monitor IP68 Waterproof, Smartwatch Compatible with iPhone Samsung Android Phones',
        price: 183.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61gCtkVYb5L._AC_SL1000_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        quantity: 56,
        isPopular: true,
        isFaviorted: true),
    Product(
        id: 'Samsung Galaxy Watch Active 23',
        title: 'Samsung Galaxy Watch Active ',
        desc:
            'Samsung Galaxy Watch Active (40MM, GPS, Bluetooth) Smart Watch with Fitness Tracking, and Sleep Analysis - Rose Gold  (US Version)',
        price: 150.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61n1c2vnPJL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        quantity: 78,
        isPopular: true,
        isFaviorted: false),
    Product(
        id: 'Samsung Galaxy Watch 3',
        title: 'Samsung Galaxy Watch 3',
        desc:
            'Samsung Galaxy Watch 3 (41mm, GPS, Bluetooth) Smart Watch with Advanced Health monitoring, Fitness Tracking , and Long lasting Battery - Mystic Silver (US Version)',
        price: 184.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81Iu41zFPwL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        quantity: 9598,
        isPopular: true,
        isFaviorted: false),
    Product(
        id: 'Samsung Galaxy Watch Active2 ',
        title: 'Samsung Galaxy Watch Active2 ',
        desc:
            'Samsung Galaxy Watch Active2 (Silicon Strap + Aluminum Bezel) Bluetooth - International (Aqua Black, R820-44mm)',
        price: 120.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/518qjbbuGZL._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        quantity: 951,
        isPopular: false,
        isFaviorted: false),
    Product(
        id: 'Huawei Watch 2 Sport Smartwatch',
        title: 'Huawei Watch 2 Sport Smartwatch',
        desc:
            'Huawei Watch 2 Sport Smartwatch - Ceramic Bezel - Carbon Black Strap (US Warranty)',
        price: 180.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71yPa1g4gWL._AC_SL1500_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Watches',
        quantity: 951,
        isPopular: true,
        isFaviorted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
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
        childAspectRatio: 300/600,
        mainAxisSpacing: 8,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        children: List.generate(
            _products.length,
            (index) => ProductCard(
                  id: _products[index].id,
                  price: _products[index].price,
                  imageURL: _products[index].imageUrl,
                  desc: _products[index].desc,
                  quantity: _products[index].quantity,
                  isPupolar: _products[index].isPopular,
                  isFaviorted: _products[index].isFaviorted,
                )),
      ),
    );
  }
}
