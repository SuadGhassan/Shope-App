import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/services/show_dialog.dart';
import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  static const routeName = "/UploadProduct";
  const UploadProduct({Key? key}) : super(key: key);

  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String? _categoryValue;
  String? _brandValue;
  final ShowDialog _showDialogObj = ShowDialog();
  bool _isLoading = false;
  File? _pickedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? url;
  var uuid = Uuid();
  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    if (isValid) {
      _formKey.currentState!.save();
      print(_productTitle);
      print(_productPrice);
      print(_productCategory);
      print(_productBrand);
      print(_productDescription);
      print(_productQuantity);
      // Use those values to send our auth request ...

      try {
        if (_pickedImage == null) {
          _showDialogObj.authErrorHandler("please pick an image", context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child("productImage")
              .child(_productTitle + ".jpg");
          await ref.putFile(
              _pickedImage!); //here will save image url in the firebaseStorage
          url = await ref.getDownloadURL();

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final _productId = uuid.v4();
          await FirebaseFirestore.instance
              .collection("products")
              .doc(_productId)
              .set({
            "productId": _productId,
            "productTitle": _productTitle,
            "productPrice": _productPrice,
            "productCategory": _productCategory,
            "productImage": url,
            "productBrand": _productBrand,
            "productDescription": _productDescription,
            "productQuantity": _productQuantity,
            "userId": _uid,
            "createAt": Timestamp
                .now(), // Timestamp is provided by firestore to take the time when the user login
          }); //and here will get the url and assign it to the url var
        }
      } catch (error) {
        _showDialogObj.authErrorHandler("$error", context);
        print("Error occured $error");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: _isLoading
                      ? Center(
                          child: Container(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Text('Upload',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center),
                ),
                GradientIcon(
                  icon: Entypo.upload,
                  size: 20,
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 5),
          Center(
            child: Card(
              margin: EdgeInsets.all(15),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Product Title"),
                                    keyboardType: TextInputType.emailAddress,
                                    key: ValueKey("Title"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _productTitle = value!;
                                    }),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                key: ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Price is missed';
                                  }
                                  return null;
                                },
                                //this is imporatnt to just allow the customer to enter number forexample if he/she copy and paste it
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Price \$',
                                ),

                                onSaved: (value) {
                                  _productPrice = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: this._pickedImage == null
                                  ? Container(
                                      height: 200,
                                      width: 200,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Theme.of(context)
                                              .backgroundColor))
                                  : Container(
                                      height: 200,
                                      width: 200,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                      child: Image.file(
                                        this._pickedImage!,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                            ),
                            Column(
                              children: [
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: _pickImageCamera,
                                        child: Icon(Icons.camera),
                                      ),
                                      Text("Camera"),
                                    ],
                                  ),
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: _pickImageGallery,
                                        child: Icon(Icons.image),
                                      ),
                                      Text("Gallery"),
                                    ],
                                  ),
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: _removeImage,
                                        child: Icon(Icons.remove_circle,
                                            color: Colors.red[900]),
                                      ),
                                      Text("Remove",
                                          style: TextStyle(
                                              color: Colors.red[900])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Container(
                                    child: TextFormField(
                                  controller: _categoryController,
                                  key: ValueKey("Category"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Category';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Add a new Category'),
                                  onSaved: (value) {
                                    _productCategory = value!;
                                  },
                                )),
                              ),
                            ),
                            DropdownButton(
                              onChanged: (String? value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value!;
                                  //_controller.text= _productCategory;
                                  print(_productCategory);
                                });
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Phones'),
                                  value: 'Phones',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Clothes'),
                                  value: 'Clothes',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Beauty & health'),
                                  value: 'Beauty',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Shoes'),
                                  value: 'Shoes',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Funiture'),
                                  value: 'Funiture',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Watches'),
                                  value: 'Watches',
                                ),
                              ],
                              hint: Text('Select a Category'),
                              value: _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Container(
                                  child: TextFormField(
                                controller: _brandController,
                                key: ValueKey("Brand"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Brand is missed';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(labelText: "Brand"),
                                onSaved: (value) {
                                  _productBrand = value!;
                                },
                              )),
                            )),
                            DropdownButton(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Brandless'),
                                  value: 'Brandless',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Addidas'),
                                  value: 'Addidas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Apple'),
                                  value: 'Apple',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Dell'),
                                  value: 'Dell',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('H&M'),
                                  value: 'H&M',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Nike'),
                                  value: 'Nike',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Samsung'),
                                  value: 'Samsung',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Huawei'),
                                  value: 'Huawei',
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _brandValue = value;
                                  _brandController.text = value!;
                                });
                              },
                              hint: Text("Brand"),
                              value: _brandValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          key: ValueKey("Description"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'product description is required';
                            }
                            return null;
                          },
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            //  counterText: charLength.toString(),
                            labelText: 'Description',
                            hintText: 'Product description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _productDescription = value!;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              //flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: ValueKey('Quantity'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Quantity is missed';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                  onSaved: (value) {
                                    _productQuantity = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
      {Key? key,
      required this.icon,
      required this.size,
      required this.gradient})
      : super(key: key);
  final IconData icon;
  final double size;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.5,
        height: size * 1.5,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
