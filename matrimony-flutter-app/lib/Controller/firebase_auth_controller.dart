import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;
  var userToken = ''.obs;
  var userId = ''.obs;
  var isEmailVerified = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn.value = true;
        userEmail.value = user.email ?? '';
        userId.value = user.uid;
        isEmailVerified.value = user.emailVerified;
        
        // Get token
        user.getIdToken().then((token) {
          userToken.value = token ?? '';
        });
      } else {
        logout();
      }
    });
  }

  void login(String email, String token, String uid) {
    isLoggedIn.value = true;
    userEmail.value = email;
    userToken.value = token;
    userId.value = uid;
    
    // Check email verification status
    final user = _auth.currentUser;
    if (user != null) {
      isEmailVerified.value = user.emailVerified;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    userEmail.value = '';
    userToken.value = '';
    userId.value = '';
    isEmailVerified.value = false;
    _auth.signOut();
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Reload user to check verification status
  Future<void> reloadUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      isEmailVerified.value = _auth.currentUser?.emailVerified ?? false;
    }
  }

  bool get hasValidToken => userToken.value.isNotEmpty;
  bool get canAccessApp => isLoggedIn.value && isEmailVerified.value;
}
