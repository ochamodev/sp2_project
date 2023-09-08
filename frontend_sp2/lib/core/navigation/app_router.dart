import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_sp2/core/navigation/routes.dart';
import 'package:frontend_sp2/ui/feature/home/home_screen.dart';
import 'package:frontend_sp2/ui/feature/register/register_user_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/main_menu.dart';
part './app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
// ignore: avoid-dynamic
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: Routes.root,
      page: HomeRoute.page,
      initial: true
    ),
    AutoRoute(
      path: Routes.registerUser,
      page: RegisterUserRoute.page
    ),
    AutoRoute(
      path: Routes.mainMenu,
      page: MainMenuRoute.page
    )
  ];
}