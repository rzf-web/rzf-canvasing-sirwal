import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/data/profile.data.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/shared/shared_pref.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future initialize() async {
    await SharedPrefs.load();
    if (GlobalVar.userId != 0) {
      await ProfileData().fetchApiData();
    }
  }

  @override
  void initState() {
    initialize().then((_) {
      if (GlobalVar.profile == null) {
        return Get.offAllNamed(Routes.login);
      } else {
        return Get.offAllNamed(Routes.employee);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 93,
              width: 100,
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 32),
              child: Image.asset(
                loginLogo,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
            const Text(
              "Tunggu Sebentar...",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
