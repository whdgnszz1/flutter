import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/pages/welcome/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();
  changePage(int index) async {
    state.index.value = index;
  }
  
  handleSignIn() {
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}