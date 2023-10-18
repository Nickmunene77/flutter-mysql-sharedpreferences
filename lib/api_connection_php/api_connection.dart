class API {
  //the 192 is your ip config v4
  static const hostConnect = "http://192.168.0.104/api_flutter_clothes";
  static const hostConnectUser = "$hostConnect/user";

  //sign up a user
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signup = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
}
