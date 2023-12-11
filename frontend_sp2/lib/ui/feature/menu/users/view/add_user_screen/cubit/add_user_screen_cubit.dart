
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/data/model/add_user_to_company_request.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';
import 'package:frontend_sp2/domain/user_operations_use_case.dart';

part 'add_user_screen_cubit.freezed.dart';

class AddUserScreenCubit extends Cubit<AddUserScreenCubitState> {
  final UserOperationsUseCase _operationsUseCase;
  final GetCurrentCompanyUseCase _getCurrentCompanyUseCase;

  final TextEditingController name = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  AddUserScreenCubit(this._operationsUseCase, this._getCurrentCompanyUseCase) : super(_Initial());

  void onSubmit() async {
    final companyId = await _getCurrentCompanyUseCase();

    final result = await _operationsUseCase.makeAddUserToCompany(
      AddUserToCompanyRequest(
          userName: name.text,
          userLastName: lastname.text,
          userEmail: email.text,
          userPassword: password.text,
          companyId: companyId,
          searchByUser: false
      )
    );

    emit(_Done());

  }

}

@freezed
class AddUserScreenCubitState with _$AddUserScreenCubitState {
  factory AddUserScreenCubitState.initial() = _Initial;
  factory AddUserScreenCubitState.done() = _Done;
}