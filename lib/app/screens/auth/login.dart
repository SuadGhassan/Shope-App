import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode=FocusNode();
  String _emailAddress = "";
  String _password = "";
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }
  //this method for submit the form after fill the textFields.
  void _submitForm() {
    final isValid = _formKey.currentState!.validate(); //this is a bool var and it will be true if the form is valid.
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      RotatedBox(
        quarterTurns: 2,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [
                Colors.teal,
                Colors.teal.withOpacity(0.5),
              ],
              [Colors.cyan.withOpacity(0.9), Colors.cyan.shade900],
            ],
            durations: [19440, 10800],
            heightPercentages: [0.20, 0.25],
            blur: MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight,
          ),
          waveAmplitude: 0,
          size: Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                //  color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.flaticon.com/icons/png/128/869/869636.png',
                  ),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey("Email"),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email Address",
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      onSaved: (value) {
                        _emailAddress = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey("Password"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Please enter a valid password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                        focusNode: _passwordFocusNode,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                            
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        labelText: "Password",
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      onSaved: (value) {
                        _password = value!;
                      },
                      obscureText: _obscureText,
                      onEditingComplete:_submitForm,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                      
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Login",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Entypo.user),
                            ],
                          ),
                          onPressed: _submitForm,
                          style: ButtonStyle(
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            // side:
                            //     BorderSide(color: Colors.grey.shade500),
                          ))),
                        ),
                        SizedBox(width: 13,)
                    ],
                  ),
            //       Padding(
            //         padding: const EdgeInsets.only(top:70.0),
            //         child: Row(
            //   children: [
            //     Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //           ),
            //           child: Divider(
            //             thickness: 1.5,
            //             color: Colors.grey,
            //           ),
            //         ),
            //     ),
            //     Text(
            //         "Or continue with",
            //         style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            //     ),
            //     Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //           ),
            //           child: Divider(
            //             thickness: 1.5,
            //             color: Colors.grey,
            //           ),
            //         ),
            //     ),
            //   ],
            // ),
            //       ),
            // SizedBox(
            //   height: 30,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ElevatedButton(
            //         child: Row(
            //           children: [
            //              Image.asset("assets/images/google-logo.png",height: 20,width: 40,),
            //               SizedBox(width: 5,),
            //             Text("Goolge",
            //                 style: TextStyle(
            //                     fontSize: 17,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.black)),
                               
                               
            //           ],
            //         ),
            //         onPressed: () {},
            //         style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(
            //               Theme.of(context).scaffoldBackgroundColor),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                   side: BorderSide(
            //                     color: Color(0xFFBA993A),
            //                   ))),
            //         )),
            //     ElevatedButton(
            //         child: Row(
            //           children: [
            //                Image.asset("assets/images/facebook-logo.png",height: 20,width: 40,color: Colors.blue,),
            //               SizedBox(width: 5,),
            //             Text("facebook",
            //                 style: TextStyle(
            //                     fontSize: 17,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.black)),
            //           ],
            //         ),
            //         onPressed: () {},
            //         style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(
            //               Theme.of(context).scaffoldBackgroundColor),
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                   side: BorderSide(
            //                     color: Color(0xFFBA993A),
            //                   ))),
            //         )),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
    //         Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     Text(
    //       "Don't have an Account?" ,
    //       style: TextStyle(fontSize: 15.0,fontFamily: "KiwiMaru",color: Colors.black,
    //     ),),
    //      SizedBox(
    //           width: 30,
    //         ),
    //     GestureDetector(
    //       onTap: (){},
    //       child: Text(
    //         "Sign Up",
    //         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,fontFamily: "KiwiMaru",color: Colors.cyan[900]),
    //       ),
    //     )
    //   ],
    // )
                ],
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
