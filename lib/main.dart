import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      getPages: AppPages.routes,
      initialRoute: AppPages.intial,
      debugShowCheckedModeBanner: false,
      supportedLocales: AppTheme.supportedLocales,
      localizationsDelegates: AppTheme.localizationsDelegates,
      theme: ThemeData(
        fontFamily: AppTheme.fontFamily,
        colorScheme: AppTheme.colorScheme,
        appBarTheme: AppTheme.appBarTheme,
        primaryColor: AppTheme.primaryColor,
        elevatedButtonTheme: AppTheme.btnTheme,
        scaffoldBackgroundColor: AppTheme.bgColor,
        floatingActionButtonTheme: AppTheme.floatBtnTheme,
      ),
    );
  }
}
