
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int idUser;
  final String userName;
  final String userLastName;
  final String userEmail;

  const UserModel({
    required this.idUser,
    required this.userName,
    required this.userLastName,
    required this.userEmail
  });

  @override
  List<Object?> get props => [
    idUser,
    userName,
    userLastName,
    userEmail
  ];

}