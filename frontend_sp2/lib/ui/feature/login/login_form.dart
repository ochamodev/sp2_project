import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenido",
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: Dimens.rowSeparationLogin),
            _UserEmailInput(),
            const SizedBox(height: Dimens.rowSeparationLogin),
            _UserPasswordInput(),
            const SizedBox(height: Dimens.rowSeparationLogin),
            const Align(
              alignment: Alignment.centerRight,
              child: _NotHavingAnAccountButton(),
            ),
            const SizedBox(height: Dimens.rowSeparationLogin),
            _SubmitButton()
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

class _UserPasswordInput extends StatelessWidget {
  const _UserPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (username) {

      },
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder()
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
          AutoRouter.of(context).navigate(MainMenuRoute(title: "Menu principal"));
        },
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
