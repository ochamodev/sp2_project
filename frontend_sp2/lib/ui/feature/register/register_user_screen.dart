

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/anim_paths.dart';
import 'package:frontend_sp2/ui/feature/register/register_form.dart';
import 'package:frontend_sp2/ui/feature/register/state/register_user_cubit.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocProvider(
      create: (_) => getIt<RegisterUserCubit>(),
      child: BlocConsumer<RegisterUserCubit, RegisterUserFormState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SizedBox(
              height: mediaQuery.size.height,
              width: mediaQuery.size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Lottie.asset(
                        AnimPaths.homePageAnim
                    ),
                  ),
                  const Expanded(
                    child: RegisterForm(),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          switch (state.registerFormStatus) {
            case RegisterFormStatusResult.error:
              showResultDialog(context, state.message, () {
                AutoRouter.of(context).pop();
                context.read<RegisterUserCubit>().resetForm();
              });
              break;
            case RegisterFormStatusResult.success:
              showResultDialog(context, "Cuenta creada exitosamente", () {
                AutoRouter.of(context).pop();
                AutoRouter.of(context).replace(const HomeRoute());
              });
              break;
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