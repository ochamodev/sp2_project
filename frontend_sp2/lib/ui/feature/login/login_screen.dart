
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/ui/feature/login/login_form.dart';
import 'package:frontend_sp2/ui/feature/login/state/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm()
              ]
          );
        },
        listener: (context, state) {
          switch (state.loginStatus) {
            case LoginFormStatus.authenticated:
              AutoRouter.of(context).replace(const MainMenuRoute());
              break;
            case LoginFormStatus.error:
              break;
            default:
              break;
          }
        },
      )
    );
  }
}