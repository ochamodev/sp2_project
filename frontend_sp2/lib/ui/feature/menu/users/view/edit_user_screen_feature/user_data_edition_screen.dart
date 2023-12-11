
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/ui/feature/menu/users/cubit/users_screen_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/cubit/edit_user_cubit.dart';

class UserDataEditionScreen extends StatelessWidget {
  final UserModel userModel;
  final Function(bool) shouldReload;
  const UserDataEditionScreen({super.key, required this.userModel, required this.shouldReload});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditUserCubit, EditUserState>(
      builder: (BuildContext context, EditUserState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimens.rowSeparationRegister),
                const _UserNameInput(),
                const SizedBox(height: Dimens.rowSeparationRegister),
                const _UserLastNameInput(),
                const SizedBox(height: Dimens.rowSeparationRegister),
                const _SubmitButton()
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, EditUserState state) {
        state.when(Initial: (v1, v2, v3) {

        }, Done: () {
          shouldReload(true);
        });
      },
    );
  }

}

class _UserNameInput extends StatelessWidget {
  const _UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<EditUserCubit>().userName,
          onChanged: (value) => context.read<EditUserCubit>().onNameChanged(value),
          decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _UserLastNameInput extends StatelessWidget {
  const _UserLastNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<EditUserCubit>().userLastName,
          onChanged: (value) => context.read<EditUserCubit>().onLastNameChanged(value),
          decoration: InputDecoration(
              labelText: 'Apellidos',
              border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ElevatedButton(
      onPressed: () {
        context.read<EditUserCubit>().onSubmit();
      },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            fixedSize: Size(mediaQuery.size.width, 50),
            backgroundColor: AppColors.defaultRedColor
        ),
        child: const Text("Guardar cambios")
    );
  }
}
