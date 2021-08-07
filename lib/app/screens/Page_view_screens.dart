import 'package:flutter/material.dart';
import 'package:shop_app/bottom_navgation_bar.dart';
import 'package:shop_app/app/screens/upload_new_product.dart';

class PageViewScreens extends StatelessWidget {
  static const routeName = "/pageViewScreens";
  const PageViewScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      children: [BottomBarPage(), UploadProduct()],
      controller: controller,
    );
  }
}
