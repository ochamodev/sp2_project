
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/ui/feature/menu/users/cubit/users_screen_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/change_password_screen_feature/change_password_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/cubit/edit_user_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/edit_user_screen_feature/user_data_edition_screen.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel userModel;
  final Function(bool) shouldReload;
  const EditUserScreen({super.key,
    required this.userModel,
    required this.shouldReload
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt.get<EditUserCubit>()..init(userModel),
        )
      ],
      child: Dialog(
        child: SizedBox(
          width: mediaQuery.height * 0.50,
          height: mediaQuery.width * 0.30,
          child: DefaultTabController(
            length: 1,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Editar usuario"),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "Datos del usuario",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  UserDataEditionScreen(userModel: userModel, shouldReload: shouldReload),
                  ChangePasswordScreen(userModel: userModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}