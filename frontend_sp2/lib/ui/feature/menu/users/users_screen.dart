
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/ui/feature/menu/users/cubit/users_screen_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/add_user_screen/add_user_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/edit_user_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/user_list_item.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UsersScreenCubit>()..getUsers(),
      child: _UsersScreenBody(),
    );
  }

}

class _UsersScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final mediaQuery = MediaQuery.of(ctx);
    return BlocBuilder<UsersScreenCubit, UsersScreenState>(
      builder: (context, state) {
        return state.when(
            loading: () {
              return const Center(
                child: LinearProgressIndicator(),
              );
            },
            loaded: (items) {
              return SizedBox(
                width: mediaQuery.size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: Dimens.topSeparation),
                        Text(
                          "Administración de usuarios",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: Dimens.topSeparation),
                        DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Nombres',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Apellidos',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Correo',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Acciones',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                          rows: items.map((e) => getRows(e, context)).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );


  }

  DataRow getRows(UserModel userModel, BuildContext ctx) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(userModel.userName)),
        DataCell(Text(userModel.userLastName)),
        DataCell(Text(userModel.userEmail)),
        DataCell(
          Row(
            children: [
              ElevatedButton(
                onPressed: () => showDialog(
                  context: ctx,
                  builder: (BuildContext context) =>  EditUserScreen(
                    userModel: userModel,
                    shouldReload: (shouldReload) {
                      if (shouldReload) {
                        ctx.read<UsersScreenCubit>().getUsers();
                      }
                      AutoRouter.of(context).pop();
                    },
                  )
                ),
                child: Text("Editar"),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ),
      ]
    );
  }
}
