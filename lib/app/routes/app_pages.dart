import 'package:get/get.dart';
import 'package:flutter_getx_base/app/modules/auth/bindings/login.binding.dart';
import 'package:flutter_getx_base/app/modules/auth/bindings/register.binding.dart';
import 'package:flutter_getx_base/app/modules/auth/views/login.view.dart';
import 'package:flutter_getx_base/app/modules/auth/views/register.view.dart';
import 'package:flutter_getx_base/app/modules/base/bindings/splash.binding.dart';
import 'package:flutter_getx_base/app/modules/base/views/splash.view.dart';

//

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      transition: Transition.noTransition,
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      transition: Transition.native,
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      transition: Transition.native,
      binding: RegisterBinding(),
    ),
  ];
}
