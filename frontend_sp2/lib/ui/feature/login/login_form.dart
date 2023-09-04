import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:frontend_sp2/core/inputs/text_field_input.dart';
import 'package:frontend_sp2/core/inputs/email_input.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/login/state/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenido",
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: Dimens.rowSeparationLogin),
            const _UserEmailInput(),
            const SizedBox(height: Dimens.rowSeparationLogin),
            const _UserPasswordInput(),
            const SizedBox(height: Dimens.rowSeparationLogin),
            const Align(
              alignment: Alignment.centerRight,
              child: _NotHavingAnAccountButton(),
            ),
            const SizedBox(height: Dimens.rowSeparationLogin),
            const _SubmitButton()
          ],
        ),
      ),
    );
  }
}

class _UserEmailInput extends StatelessWidget {
  const _UserEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previousState, currentState) {
        return previousState.email != currentState.email;
      },
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<LoginCubit>().onEmailChanged(value),
          decoration: InputDecoration(
              labelText: 'Correo',
              border: const OutlineInputBorder(),
              errorText: state.email.error?.text()
          ),
        );
      },
    );
  }
}

class _UserPasswordInput extends StatelessWidget {
  const _UserPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previousState, currentState) {
        return previousState.password != currentState.password;
      },
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context
              .read<LoginCubit>().onPasswordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Contraseña',
              border: const OutlineInputBorder(),
              errorText: state.password.error?.text()
          ),
        );
      },
    );
  }
}

class _NotHavingAnAccountButton extends StatelessWidget {
  const _NotHavingAnAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AutoRouter.of(context).navigate(const RegisterUserRoute());
      },
      child: RichText(
          text: TextSpan(
              text: '¿Aún no tienes una cuenta?',
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text: ' Registrate aquí',
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.defaultBlueColor
                    )
                )
              ]
          )
      ),
    );
  }

}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previousState, currentState) {
        return previousState.formIsValid != currentState.formIsValid;
      },
      builder: (context, state) {
        if (state.status.isInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ElevatedButton(
              onPressed: state.formIsValid && state.password.value.isNotEmpty ?
                  () {
                context.read<LoginCubit>().submitForm();
              }
                  : null,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  fixedSize: Size(mediaQuery.size.width, 50),
                  backgroundColor: AppColors.defaultRedColor
              ),
              child: const Text("Iniciar sesión")
          );
        }
      }
    );
  }

}
