import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/show_dialog.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUpScreen";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  String _fullName = "";
  String _emailAddress = "";
  String _password = "";
  late int _phoneNumber;
  bool _obscureText = true;
  File? _pickedImage;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ShowDialog _showDialogObj = ShowDialog();
  bool _isLoading = false;
  String? url;


  //this method for submit the form after fill the textFields.
  void _submitForm() async {
    final isValid = _formKey.currentState!
        .validate(); //this is a bool var and it will be true if the form is valid.
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    if (isValid) {
      _formKey.currentState!.save();

      try {
        if (_pickedImage == null) {
          _showDialogObj.authErrorHandler("please pick an image", context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("userImages")
              .child(_fullName + ".jpg");
          await ref.putFile(
              _pickedImage!); //here will save image url in the firebaseStorage
          url = await ref
              .getDownloadURL(); 
               await _auth
            .createUserWithEmailAndPassword(
                email: _emailAddress.toLowerCase().trim(),
                password: _password.trim())
            .then((value) =>
                Navigator.canPop(context) ? Navigator.pop(context) : null);
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(_fullName);
        user.updateEmail(_emailAddress);
        user.reload();
        await FirebaseFirestore.instance.collection("users").doc(_uid).set({
          "id": _uid,
          "name": _fullName,
          "email": _emailAddress,
          "phoneNumber": _phoneNumber,
          "imageUrl": url,
          "joinAt": formattedDate,
          "createAt": Timestamp
              .now(), // Timestamp is provided by firestore to take the time when the user login
        });//and here will get the url and assign it to the url var
        }
       
      } catch (error) {
        _showDialogObj.authErrorHandler("$error", context);
        print("Error occured $error");
      } 
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }
   @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
   
    super.dispose();
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
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: CircleAvatar(
                        radius: 72,
                        backgroundColor: Colors.black12,
                        child: CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: 65,
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage!),
                        ))),
                Positioned(
                    top: 120,
                    left: 110,
                    child: RawMaterialButton(
                      elevation: 10,
                      fillColor: Colors.grey.shade500,
                      child: Icon(Icons.add_a_photo),
                      shape: CircleBorder(),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("Choose a photo",
                                      style: TextStyle(
                                          color: Colors.cyan[900],
                                          fontWeight: FontWeight.w600)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          onTap: _pickImageCamera,
                                          splashColor: Colors.brown,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(Icons.camera,
                                                    color: Colors.brown),
                                              ),
                                              Text(" Camera",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: _pickImageGallery,
                                          splashColor: Colors.brown,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(Icons.image,
                                                    color: Colors.brown),
                                              ),
                                              Text(" Gallery",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _pickedImage = null;
                                            });
                                            Navigator.pop(context);
                                          },
                                          splashColor: Colors.brown,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(Icons.remove_circle,
                                                    color: Colors.red[900]),
                                              ),
                                              Text("remove",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red[900])),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                      },
                    ))
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey("Name "),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        labelText: "Full name",
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      onSaved: (value) {
                        _fullName = value!;
                      },
                    ),
                  ),
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
                      focusNode: _emailFocusNode,
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
                        //  onEditingComplete:() => FocusScope.of(context)
                        //       .requestFocus(_phoneFocusNode),
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
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneFocusNode)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      key: ValueKey("Phone number "),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      focusNode: _phoneFocusNode,
                      onEditingComplete: _submitForm,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        filled: true,
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone number",
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      onSaved: (value) {
                        _phoneNumber = int.parse(value!);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign Up",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Entypo.user_add),
                                ],
                              ),
                              onPressed: _submitForm,
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                // side:
                                //     BorderSide(color: Colors.grey.shade500),
                              ))),
                            ),
                      SizedBox(
                        width: 13,
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //             horizontal: 10,
                  //           ),
                  //           child: Divider(
                  //             thickness: 1.5,
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ),
                  //       Text(
                  //         "Or Sign up with",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 15),
                  //       ),
                  //       Expanded(
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //             horizontal: 10,
                  //           ),
                  //           child: Divider(
                  //             thickness: 1.5,
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     ElevatedButton(
                  //         child: Row(
                  //           children: [
                  //             Image.asset(
                  //               "assets/images/google-logo.png",
                  //               height: 20,
                  //               width: 40,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
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
                  //           shape: MaterialStateProperty
                  //               .all<RoundedRectangleBorder>(
                  //                   RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(15),
                  //                       side: BorderSide(
                  //                         color: Color(0xFFBA993A),
                  //                       ))),
                  //         )),
                  //     ElevatedButton(
                  //         child: Row(
                  //           children: [
                  //             Image.asset(
                  //               "assets/images/facebook-logo.png",
                  //               height: 20,
                  //               width: 40,
                  //               color: Colors.blue,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
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
                  //           shape: MaterialStateProperty
                  //               .all<RoundedRectangleBorder>(
                  //                   RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(15),
                  //                       side: BorderSide(
                  //                         color: Color(0xFFBA993A),
                  //                       ))),
                  //         )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       "Don't have an Account?",
                  //       style: TextStyle(
                  //         fontSize: 15.0,
                  //         fontFamily: "KiwiMaru",
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 30,
                  //     ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Text(
                  //     "Sign Up",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16.0,
                  //         fontFamily: "KiwiMaru",
                  //         color: Colors.cyan[900]),
                  //   ),
                  // )
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
