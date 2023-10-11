import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/core/inputs/text_field_input.dart';
import 'package:frontend_sp2/core/inputs/email_input.dart';
import 'package:frontend_sp2/ui/feature/register/state/register_user_cubit.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crear cuenta",
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _UserNameInput(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _UserLastNameInput(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _UserCompanyNit(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _UserCompanyName(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _UserEmailInput(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _PasswordInput(),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const Align(
                alignment: Alignment.centerRight,
                child: _AlreadyHavingAnAccountButton(),
              ),
              const SizedBox(height: Dimens.rowSeparationRegister),
              const _SubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _UserEmailInput extends StatelessWidget {
  const _UserEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      buildWhen: (p, c) {
        return p.email != c.email;
      },
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userEmailCtrl,
          onChanged: (value) => context
              .read<RegisterUserCubit>()
              .onEmailChanged(value),
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

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userPasswordCtrl,
          onChanged: (value) => context.read<RegisterUserCubit>().onPasswordChanged(value),
          obscureText: state.obscurePassword,
          decoration: InputDecoration(
              labelText: 'Contraseña',
              border: const OutlineInputBorder(),
              errorText: state.password.error?.text(),
              suffixIcon: IconButton(
                icon: Icon(
                    state.obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off
                ),
                onPressed: () {
                  context.read<RegisterUserCubit>().showPassword();
                },
              )
          ),
        );
      },
    );
  }
}

class _UserNameInput extends StatelessWidget {
  const _UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userNameCtrl,
          onChanged: (value) => context.read<RegisterUserCubit>().onNameChanged(value),
          decoration: InputDecoration(
              labelText: 'Nombre',
              border: const OutlineInputBorder(),
              errorText: state.nameInput.error?.text()
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
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userLastNameCtrl,
          onChanged: (value) => context.read<RegisterUserCubit>().onLastNameChanged(value),
          decoration: InputDecoration(
              labelText: 'Apellidos',
              border: const OutlineInputBorder(),
              errorText: state.lastNameInput.error?.text()
          ),
        );
      },
    );
  }
}

class _UserCompanyNit extends StatelessWidget {
  const _UserCompanyNit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userCompanyNitCtrl,
          onChanged: (value) => context.read<RegisterUserCubit>().onNitInputChanged(value),
          decoration: InputDecoration(
              labelText: 'Nit de la empresa',
              border: const OutlineInputBorder(),
              errorText: state.nitInput.error?.text()
          ),
        );
      },
    );
  }
}

class _UserCompanyName extends StatelessWidget {
  const _UserCompanyName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<RegisterUserCubit>().userCompanyNameCtrl,
          onChanged: (value) => context.read<RegisterUserCubit>().onCompanyNameChanged(value),
          decoration: InputDecoration(
              labelText: 'Nombre de la empresa',
              border: const OutlineInputBorder(),
              errorText: state.companyNameInput.error?.text()
          ),
        );
      },
    );
  }
}

class _AlreadyHavingAnAccountButton extends StatelessWidget {
  const _AlreadyHavingAnAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AutoRouter.of(context).replace(const HomeRoute());
      },
      child: RichText(
          text: TextSpan(
              text: '¿Ya tienes una cuenta?',
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text: ' Ingresa acá',
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
    return BlocBuilder<RegisterUserCubit, RegisterUserFormState>(
      buildWhen: (p, c) {
        getIt<Logger>().d("Status buildWhen ${c}");
        if (p.formIsValid != c.formIsValid) {
          return true;
        }
        if (c.status.isInProgress) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state.status.isInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ElevatedButton(
              onPressed: state.formIsValid && state.password.value.isNotEmpty ? () {
                context.read<RegisterUserCubit>().submitForm();
              } : null,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  fixedSize: Size(mediaQuery.size.width, 50),
                  backgroundColor: AppColors.defaultRedColor
              ),
              child: const Text("Registrarme")
          );
        }
      },
    );
  }
}
