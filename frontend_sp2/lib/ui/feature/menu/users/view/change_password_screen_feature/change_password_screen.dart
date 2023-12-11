
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/change_password_screen_feature/cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  final UserModel userModel;
  const ChangePasswordScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.rowSeparationRegister),
            const SizedBox(height: Dimens.rowSeparationRegister),
            const Text(""),
          ],
        ),
      ),
    );
  }

}


