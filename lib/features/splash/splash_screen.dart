
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/local_storage/auth_utility_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  Future<void> goToNextPage() async {
    await AuthUtilityController.getAccessToken();
    await AuthUtilityController.getRefreshToken();
    await AuthUtilityController.getUserRole();
    Future.delayed(const Duration(seconds: 3), () {
      AuthUtilityController.isLoggedIn ? context.go(RoutesPath.homeScreen) : context.go(RoutesPath.loginScreen);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Align(
              alignment: Alignment.center,
              child: Text("This  is Splash",style: TextStyle(fontSize: 25),)),
          SizedBox(height: 20,),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}