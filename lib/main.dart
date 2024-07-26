import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/auth_controller.dart';
import 'package:lolketing_flutter/ui/auth/login.dart';
import 'package:lolketing_flutter/ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: InitialScreen());
  }
}

class InitialScreen extends StatelessWidget {
  InitialScreen({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (controller.isLoggedIn.value) {
        return const HomeScreen();
      } else {
        return const LoginScreen();
      }
    });
  }
}
