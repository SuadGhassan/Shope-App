import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/wishlist.dart';
import 'package:shop_app/const/my_icons.dart';
import 'package:shop_app/provider/dart_theme_provider.dart';

class UserPage extends StatefulWidget {
  // const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late ScrollController _scrollController;
  var top = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //in this variable we will listen to the darkThemeProvider class for the changes when switch to dark mode
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 4,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey,
                            Colors.greenAccent,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: AnimatedOpacity(
                        opacity: top <= 110.0 ? 1.0 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              // 'top.toString()',
                              'Guest',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).textSelectionColor),
                            ),
                          ],
                        ),
                      ),
                      background: Image(
                        image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: userTitle(context, "User Bag"),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.blueGrey[200],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () =>Navigator.of(context).pushNamed(WishlistPage.routeName),
                        title: Text("Wishlist"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(MyAppIcons.wishlist),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () =>Navigator.of(context).pushNamed(CartPage.routeName),
                        title: Text("Cart"),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(MyAppIcons.cart),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: userTitle(context, "User Information"),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.blueGrey[200],
                  ),
                  userListTile(context, "Email", "soadalkogok082@gmail.com", 0),
                  userListTile(context, "Phone Number", "058114472", 1),
                  userListTile(
                      context, "Shipping address", "Jeddah,Alhamra", 2),
                  userListTile(context, "Joined data", "17/2", 3),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: userTitle(context, "User Settings"),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.blueGrey[200],
                  ),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    leading: Icon(Icons.dark_mode),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.cyan[900],
                    title: Text('Dark Theme'),
                  ),
                  userListTile(context, "Logout", "", 4),
                ],
              ),
            )
          ],
        ),
        _buildFab(),
      ],
    ));
  }

//buildFab widget with return transform animated widget
  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      //animated widget
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.teal.withOpacity(0.9),
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  //UserTile Widget
  Widget userTitle(BuildContext context, String infoTitle) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(infoTitle,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      );
  //UserIconsa List
  List<IconData> _userIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
  ];
  //UserListTile Widget
  Widget userListTile(
    BuildContext context,
    String title,
    String subTitle,
    int index,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userIcons[index]),
        ),
      ),
    );
  }
}
