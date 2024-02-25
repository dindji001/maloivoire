class ApiEndPoints {
  static final String baseUrl =
      'https://www.maloivoire.com/public/controllers/';
  static final String baseUrl2 = 'https://dev.sycapay.com/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String loginUser = 'LoginUser.php';
  final String registerUser = 'RegisterUser.php';
  final String forgetPassword = 'ForgetPassword.php';
  final String getGategory = 'GetSubNormal.php';
  final String loginPayment = 'login.php';
  final String checkoutpayPayment = 'checkoutpay.php';
  final String newOder = 'NewOrder.php';
  final String getAllOrder = "GetMyOrdered.php";
  final String UpdatePassword = 'UpdatePassword.php';
  final String UpdateUser = 'UpdateUser.php';
}
