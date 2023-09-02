import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

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
              "Crear cuenta",
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _UserNameInput(),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _UserLastNameInput(),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _UserCompanyNit(),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _UserCompanyName(),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _UserEmailInput(),
            const SizedBox(height: Dimens.rowSeparationRegister),
            _PasswordInput(),
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
    );
  }
}

class _UserEmailInput extends StatelessWidget {
  const _UserEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Correo',
          border: OutlineInputBorder()
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Contraseña',
          border: OutlineInputBorder()
      ),
      obscureText: true,
    );
  }
}

class _UserNameInput extends StatelessWidget {
  const _UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Nombre',
          border: OutlineInputBorder()
      ),
    );
  }
}

class _UserLastNameInput extends StatelessWidget {
  const _UserLastNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Apellidos',
          border: OutlineInputBorder()
      ),
    );
  }
}

class _UserCompanyNit extends StatelessWidget {
  const _UserCompanyNit({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Nit de la empresa',
          border: OutlineInputBorder()
      ),
    );
  }
}

class _UserCompanyName extends StatelessWidget {
  const _UserCompanyName({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      decoration: const InputDecoration(
          labelText: 'Nombre de la empresa',
          border: OutlineInputBorder()
      ),
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
    return ElevatedButton(
        onPressed: () {

        },
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
}
