class StripeTranscationResponse {
  late String message;
  late bool success;
  StripeTranscationResponse(this.message, this.success);
}

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = "${StripeService.apiBase}/reporting";
  static String secret =
      "sk_test_51JLAWrEOWJtDpD9zkg6H0RxNkSfIdvJGFU25zqFzXlwGqTVc2LnADjDxsTJK6eHxYL46I3GYNotlU09fskEQAlBE009CtC4gL3";

  
}
