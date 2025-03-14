import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var name = "".obs;
  var email = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> saveUserData(String userName, String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userName);
    await prefs.setString('email', userEmail);

    name.value = userName;
    email.value = userEmail;
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? "No Name";
    email.value = prefs.getString('email') ?? "No Email";
  }
}
