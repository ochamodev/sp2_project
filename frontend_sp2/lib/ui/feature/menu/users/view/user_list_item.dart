
import 'package:flutter/material.dart';
import 'package:frontend_sp2/domain/user_model.dart';

class UserListItem extends StatelessWidget {
  final UserModel model;
  final Function() onClick;

  const UserListItem({ required this.model, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          children: [
            _UserListRowItem(label: "Nombres:", text: model.userName),
            _UserListRowItem(label: "Apellidos:", text: model.userLastName),
            _UserListRowItem(label: "Correo:", text: model.userEmail),
          ],
        ),
      ),
    );
  }

}

class _UserListRowItem extends StatelessWidget {

  final String label;
  final String text;

  const _UserListRowItem({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "$label ",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold
            ),
            children: <TextSpan>[
              TextSpan(
                text: text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.normal
                )
              ),
            ]
        )
    );
  }

}