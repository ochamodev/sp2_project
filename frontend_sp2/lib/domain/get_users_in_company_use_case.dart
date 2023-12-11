
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/get_users_in_company_caller.dart';
import 'package:frontend_sp2/data/model/current_company_request.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';
import 'package:frontend_sp2/domain/user_model.dart';

class GetUsersInCompanyUseCase {
  final GetUsersInCompanyCaller _getUsersInCompanyCaller;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;
  GetUsersInCompanyUseCase(this._getUsersInCompanyCaller, this._getCurrentCompanyUseCase);

  Future<Either<ResponseCode, List<UserModel>>> call() async {
    var company = await _getCurrentCompanyUseCase();
    var currentCompanyRequest = CurrentCompanyRequest(currentCompany: company);
    final callResult = await _getUsersInCompanyCaller.getUsersInCompany(currentCompanyRequest);

    Either<ResponseCode, List<UserModel>> response = callResult.match(
            (error) {
              return Either.left(error);
            },
            (result) {
              var users = result.users.map((user) {
                return UserModel(
                  idUser: user.id,
                  userEmail: user.userEmail,
                  userName: user.userName,
                  userLastName: user.userLastName
                );
              }).toList();
              return Either.right(users);
            }
    );

    return response;

  }

}