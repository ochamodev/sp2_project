
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/user_list_item.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _UsersScreenBody(),
    );
  }

}

class _UsersScreenBody extends StatelessWidget {

  final List<UserModel> items = [
    const UserModel(
        idUser: 1,
        userName: "Otto Francisco",
        userLastName: "Chamo Cheley",
        userEmail: "cheleyotto98@gmail.com"
    ),
    UserModel(
        idUser: 2,
        userName: "Marian Irene",
        userLastName: "Vela",
        userEmail: "cheleyotto98@gmail.com"
    ),
    UserModel(
        idUser: 3,
        userName: "Axel",
        userLastName: "Benavides",
        userEmail: "cheleyotto98@gmail.com"
    ),

  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    /*return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var model = items[index];
            return UserListItem(
                model: model,
                onClick: () {
                }
            );
          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: mediaQuery.size.height * 0.10
        ),
        ),
      ),
    );*/

    return SizedBox(
      width: mediaQuery.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Administración de usuarios",
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () {  },
                child: const Text("Agregar usuario"),
              ),
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
                rows: items.map((e) => getRows(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );


  }

  DataRow getRows(UserModel userModel) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(userModel.userName)),
        DataCell(Text(userModel.userLastName)),
        DataCell(Text(userModel.userEmail)),
        DataCell(
          Row(
            children: [
              ElevatedButton(
                onPressed: () {

                },
                child: Text("Editar"),
              ),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.defaultRedColor
                ),
                onPressed: () {

                },
                child: Text("Eliminar"),
              )
            ],
          )
        ),
      ]
    );
  }

}
