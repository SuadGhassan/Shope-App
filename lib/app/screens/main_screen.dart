import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/landing_page.dart';
import 'package:shop_app/bottom_navgation_bar.dart';
import 'package:shop_app/widgets/upload_new_product.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/MainScreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      children: [LandingPage(), BottomBarPage(), UploadProduct()],
      controller: controller,
    );
  }
}
