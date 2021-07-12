import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/cart.dart';
import 'package:shop_app/app/screens/feeds.dart';
import 'package:shop_app/app/screens/home.dart';
import 'package:shop_app/app/screens/search.dart';
import 'package:shop_app/app/screens/user.dart';

class BottomBarPage extends StatefulWidget {
  static const routeName = "\BottomScreen";
  BottomBarPage({Key? key}) : super(key: key);

  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  late List<Map<String, Widget>> _pages;

  int _selectedIndex =0 ;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
        
      },
      {
        'page': CartPage(),
        
      },
      {
        'page': SearchPage(),
      },
      {
        'page': FeedsPage(),
      },
      {
        'page': UserPage(),
      }
    ];
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar:BottomAppBar(
        notchMargin: 3,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child:Container(
          decoration: BoxDecoration(border: Border(top:BorderSide(width: 0.5,color: Colors.cyan.withOpacity(0.5)),)),
          child: BottomNavigationBar(
          elevation: 5,
          onTap: _selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          selectedItemColor: Colors.cyan[900],
          selectedLabelStyle: TextStyle(color: Colors.cyan[900],),
          currentIndex:_selectedIndex, // it is important to change the color of the selected button
          items: [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.home), tooltip: "Home"),
            BottomNavigationBarItem(
                label: "Cart", icon: Icon(Icons.shopping_bag), tooltip: "Cart"),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search,color: Colors.transparent,)),
            BottomNavigationBarItem(
                label: "Feed", icon: Icon(Icons.feed_outlined), tooltip: "Feed"),
                            BottomNavigationBarItem(
                label: "User", icon: Icon(Icons.person), tooltip: "User"),

          ],
      ),
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.cyan[900],
        elevation: 5,
        child: Icon(Icons.search),
        tooltip: "search",
        onPressed:(){
        setState(() {
          _selectedIndex=2;
        });
        
      },),
    );
  }
}
