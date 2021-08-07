import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:shop_app/services/show_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = "/ForgetPassword";
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _emailAddress = "";
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ShowDialog _showDialogObj = ShowDialog();
  bool _isLoading = false;

  void _submitForm() async {
    final isValid = _formKey.currentState!
        .validate(); //this is a bool var and it will be true if the form is valid.
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
         await _auth.sendPasswordResetEmail(
            email: _emailAddress.toLowerCase().trim());
        Fluttertoast.showToast(
            msg: "An email has been sent, check your email please",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        _showDialogObj.authErrorHandler("$error", context);

        print("$error");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            Text("Forgot Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Reset password",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Entypo.key),
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
            ),
          ],
        ),
      ),
    );
  }
}
