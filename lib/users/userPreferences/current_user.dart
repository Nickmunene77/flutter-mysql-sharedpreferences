import 'package:fluttterchat/users/model/user.dart';
import 'package:fluttterchat/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '').obs;
  User get user => _currentUser.value;
  getUserIfo() async {
    //info from localphone storage
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}
