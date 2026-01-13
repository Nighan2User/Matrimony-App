import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;
  var userToken = ''.obs;
  var userId = ''.obs;

  void login(String email, String token, String uid) {
    isLoggedIn.value = true;
    userEmail.value = email;
    userToken.value = token;
    userId.value = uid;
  }

  void logout() {
    isLoggedIn.value = false;
    userEmail.value = '';
    userToken.value = '';
    userId.value = '';
  }

  bool get hasValidToken => userToken.value.isNotEmpty;
}
