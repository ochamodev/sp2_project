

import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/model/add_user_to_company_request.dart';
import 'package:frontend_sp2/data/model/change_password_request.dart';
import 'package:frontend_sp2/data/model/remove_user_from_company_request.dart';
import 'package:frontend_sp2/data/model/update_user_request.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/user_operations_caller.dart';
import 'package:logger/logger.dart';

class UserOperationsUseCase {
  final UserOperationsCaller _userOperationsCaller;
  final Logger _logger;

  UserOperationsUseCase(this._userOperationsCaller, this._logger);

  Future<Either<ResponseCode, BaseResponse>> makeUserUpdate(UpdateUserRequest request) async {
    final result = await _userOperationsCaller.makeRequest(NetworkCallMethods.updateUser, request);
    return result;
  }

  Future<Either<ResponseCode, BaseResponse>> makePasswordChange(ChangePasswordRequest request) async {
    final result = await _userOperationsCaller.makeRequest(NetworkCallMethods.changePassword, request);
    return result;
  }

  Future<Either<ResponseCode, BaseResponse>> makeAddUserToCompany(AddUserToCompanyRequest request) async {
    final result = await _userOperationsCaller.makeRequest(NetworkCallMethods.addUserCompany, request);
    return result;
  }

  Future<Either<ResponseCode, BaseResponse>> makeUserRemove(RemoveUserFromCompanyRequest request) async {
    final result = await _userOperationsCaller.makeRequest(NetworkCallMethods.removeUserFromCompany, request);
    return result;
  }

}