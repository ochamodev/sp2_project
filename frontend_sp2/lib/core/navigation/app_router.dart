import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_sp2/core/navigation/routes.dart';
import 'package:frontend_sp2/ui/feature/login_screen.dart';

part './app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
// ignore: avoid-dynamic
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: Routes.root,
      page: LoginRoute.page,
      initial: true
    )
  ];
}