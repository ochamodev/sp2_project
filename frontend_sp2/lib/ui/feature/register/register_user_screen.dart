

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/anim_paths.dart';
import 'package:frontend_sp2/ui/feature/register/register_form.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
  }

}