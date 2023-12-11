
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/add_user_screen/cubit/add_user_screen_cubit.dart';

class AddUserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      child: BlocProvider(
        create: (_) => getIt.get<AddUserScreenCubit>(),
        child: SizedBox(
          width: mediaQuery.height * 0.50,
          height: mediaQuery.width * 0.30,
          child: BlocConsumer<AddUserScreenCubit, AddUserScreenCubitState>(
            builder: (BuildContext context, AddUserScreenCubitState state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Agregar usuario",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: Dimens.rowSeparationRegister),
                      TextField(
                          controller: context.read<AddUserScreenCubit>().name,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: const OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: Dimens.rowSeparationRegister),
                      TextField(
                          controller: context.read<AddUserScreenCubit>().lastname,
                          decoration: InputDecoration(
                            labelText: 'Apellido',
                            border: const OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: Dimens.rowSeparationRegister),
                      TextField(
                          controller: context.read<AddUserScreenCubit>().email,
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            border: const OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: Dimens.rowSeparationRegister),
                      TextField(
                          controller: context.read<AddUserScreenCubit>().password,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: const OutlineInputBorder(),
                          )
                      ),
                      const SizedBox(height: Dimens.rowSeparationRegister),
                      ElevatedButton(
                          onPressed: () {
                            context.read<AddUserScreenCubit>().onSubmit();
                          }, child: Text("Agregar usuario"))
                    ],
                  ),
                ),
              );
            }, listener: (BuildContext context, AddUserScreenCubitState state) {
              state.when(initial: () {}, done: () {
                AutoRouter.of(context).pop();
              });
          },

          )
        ),
      ),
    );
  }

}