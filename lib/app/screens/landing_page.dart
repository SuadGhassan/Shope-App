import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:shop_app/app/screens/auth/login.dart';
import 'package:shop_app/bottom_navgation_bar.dart';

import 'auth/sign_up.dart';

class LandingPage extends StatefulWidget {
  static const routeName="/LandingPage";
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> images = [
    'https://media.istockphoto.com/photos/man-at-the-shopping-picture-id868718238?k=6&m=868718238&s=612x612&w=0&h=ZUPCx8Us3fGhnSOlecWIZ68y3H4rCiTnANtnjHk0bvo=',
    'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F0x0.jpg%3Ffit%3Dscale',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
  ];
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus){
            if (animationStatus== AnimationStatus.completed){
                 _animationController.reset();
                 _animationController.forward();
            }
          });
          _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        CachedNetworkImage(
          imageUrl:images[1],
          // placeholder: (context, url) => Image.network(
          //   'https://image.flaticon.com/icons/png/128/564/564619.png',
          //   fit: BoxFit.contain,
          // ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            size: 300,
            color: Colors.red[900],
          ),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment:FractionalOffset(_animation.value,0),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Welcome!",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Welcome to the biggest online store",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Login",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Entypo.user),
                        ],
                      ),
                      onPressed: () {Navigator.pushNamed(context, LoginScreen.routeName);},
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        // side:
                        //     BorderSide(color: Colors.grey.shade500),
                      ))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign up",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Entypo.user_add),
                      ],
                    ),
                    onPressed: () {Navigator.pushNamed(context, SignUp.routeName);},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFBA993A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  "Or continue with",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text("Goolge +",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Color(0xFFBA993A),
                              ))),
                    )),
                ElevatedButton(
                    child: Text("Sign in as a guest",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    onPressed: () {Navigator.pushNamed(context, BottomBarPage.routeName);},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                         Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Color(0xFFBA993A),
                              ))),
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        )
      ]),
    );
  }
}
