import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart ' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  late String message;
  late bool success;
  StripeTransactionResponse({required this.message, required this.success, });
}

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = "${StripeService.apiBase}/reporting";
  static Uri paymentApiUri=Uri.parse(paymentApiUrl); // this important to change from string to Url to pass it to the server 
  static String secret =
      "sk_test_51JLAWrEOWJtDpD9zkg6H0RxNkSfIdvJGFU25zqFzXlwGqTVc2LnADjDxsTJK6eHxYL46I3GYNotlU09fskEQAlBE009CtC4gL3";

  static Map<String, String> headers = {
    'Authorization': "Bearer${StripeService.secret}",
    'content-type': 'application/x-www-form-urlencoded',
  };
//this method will call later at the initState method to be inilized.
  static init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey:
          "pk_test_51JLAWrEOWJtDpD9zkWVTz2bFtC7f6XjLmAPp6dlZPUwQtiL2YVayUzvsg1GvQeumfwpBY7kAWTJI2IMenhhvZaBK00VBTBLlRp",
      merchantId: "test",
      androidPayMode: "test",
    ));
  }

  // this method wil used to send the data to the stripe account
  static Future<Map<String, dynamic>?>? createPaymentIntent(
      String amount, String currency) async{
    try {
      Map<String,dynamic> body={
       
    "amount": amount,
    "currency": currency,
      };
      var response= await http.post(paymentApiUri,headers: headers,body: body);
      return jsonDecode(response.body);
    } catch (error) {
      print ('an error occured in the payment intent $error ');
    }
     return null;
  }
  //this method for making payment method 
  static Future<StripeTransactionResponse> payWithNewCard(
      { String? amount,  String? currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount!, currency!);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent!['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $error', success: false);
    }
  }
// this method created for PlatformException to give an error message if the user cancel the payment
  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }
}
