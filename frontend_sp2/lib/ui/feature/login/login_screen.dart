
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/ui/feature/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginForm()
        ]
    );
  }
}