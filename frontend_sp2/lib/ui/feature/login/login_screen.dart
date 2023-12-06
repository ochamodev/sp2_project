
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            case LoginStatusResult.success:
              AutoRouter.of(context).popUntilRoot();
              AutoRouter.of(context).replace(const SelectCompanyRoute());
              break;
            case LoginStatusResult.error:
              showResultDialog(context, state.message, () {
                AutoRouter.of(context).pop();
                context.read<LoginCubit>().resetForm();
              });
            default:
              break;
          }
        },
      )
    );
  }

  Future<void> showResultDialog(
      BuildContext context,
      String message,
      Function() result) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Mensaje"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: result,
              child: const Text("Ok"),
            )
          ],
        );
      }
    );
  }

}