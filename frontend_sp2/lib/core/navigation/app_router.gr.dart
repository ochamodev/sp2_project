// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MainMenuRoute.name: (routeData) {
      final args = routeData.argsAs<MainMenuRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainMenuScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    RegisterUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterUserScreen(),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainMenuScreen]
class MainMenuRoute extends PageRouteInfo<MainMenuRouteArgs> {
  MainMenuRoute({
    Key? key,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          MainMenuRoute.name,
          args: MainMenuRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'MainMenuRoute';

  static const PageInfo<MainMenuRouteArgs> page =
      PageInfo<MainMenuRouteArgs>(name);
}

class MainMenuRouteArgs {
  const MainMenuRouteArgs({
    this.key,
    required this.title,
  });

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'MainMenuRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [RegisterUserScreen]
class RegisterUserRoute extends PageRouteInfo<void> {
  const RegisterUserRoute({List<PageRouteInfo>? children})
      : super(
          RegisterUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
