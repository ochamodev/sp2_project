
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';



class AppSp2 extends StatelessWidget {
  final AppRouter appRouter;

  AppSp2({
    Key? key,
    AppRouter? appRouter,
  }) : appRouter = appRouter ?? getIt<AppRouter>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: "SP2 Proyecto",
      builder: (context, child) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: Dimens.defaultTextScaleFactor,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        scrollbarTheme: AppColors.scrollbarTheme,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.5,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.25,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
            color: Colors.black,
          ),
          button: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
            color: Colors.black,
          ),
          caption: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
            color: Colors.black,
          ),
          overline: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}