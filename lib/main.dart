import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quyoshli/config/root_binding.dart';
import 'package:quyoshli/pages/home/home_page.dart';
import 'package:quyoshli/pages/main_subpages/partners_page.dart';
import 'package:quyoshli/pages/main_subpages/service_page.dart';
import 'package:quyoshli/pages/splash/splash_page.dart';
import 'package:quyoshli/services/db_service.dart';
import 'package:quyoshli/services/lang_service.dart';
import 'package:quyoshli/services/root_service.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() async{
  await DBService.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 790),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quyoshli',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
          ),
          initialRoute: SplashPage.id,
          routes: {
            SplashPage.id: (context) => const SplashPage(),
            HomePage.id: (context) => const HomePage(),
            ServicePage.id: (context) => const ServicePage(),
            PartnersPage.id: (context) => const PartnersPage(),
          },
          initialBinding: RootBinding(),
          translations: LangService(),
          locale: LangService.locale,
          fallbackLocale: LangService.fallbackLocale,
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 250),
          supportedLocales: LangService.locales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
