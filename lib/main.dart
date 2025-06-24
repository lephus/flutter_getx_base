import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/core/service/firebase_message.service.dart';
import 'package:flutter_getx_base/app/core/service/hive.helper.dart';
import 'package:flutter_getx_base/app/core/service/local_notification.service.dart';
import 'package:flutter_getx_base/app/core/settings/hive_keys.dart';
import 'package:flutter_getx_base/app/core/theme/app_theme.dart';
import 'package:flutter_getx_base/app/core/utils/file.utils.dart';
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:flutter_getx_base/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/core/utils/global.dart' as global;
import 'app/routes/app_pages.dart';

void main() async {
  await initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    global.isForeground = state == AppLifecycleState.resumed;
  }

  @override
  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: 'Flutter app',
        locale: Get.deviceLocale,
        fallbackLocale: Get.fallbackLocale,
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        defaultTransition: Transition.native,
        builder: (context, child) {
          SizeConfig.init(context);
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}

Future<void> initializeApp() async {
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessageService.initialize();
  await FileUtil.getApplicationDir();
  await LocalNotificationService().initialize();
  await HiveHelper.openBox(HiveKeys.authBox);
  initializeDateFormatting();
  configureDependencies();
}
