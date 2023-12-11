
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/data/model/update_user_request.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:frontend_sp2/domain/user_operations_use_case.dart';

part 'edit_user_cubit.freezed.dart';

class EditUserCubit extends Cubit<EditUserState> {
  late UserModel model;
  final UserOperationsUseCase _operationsUseCase;
  EditUserCubit(this._operationsUseCase) : super(_Initial());

  TextEditingController userName = TextEditingController();
  TextEditingController userLastName = TextEditingController();

  void init(UserModel userModel) {
    model = userModel;
    userName.text = userModel.userName;
    userLastName.text = userModel.userLastName;
  }

  void onNameChanged(String value) {
    emit(
      _Initial(
        isFormValid: true,
        lastNameError: "",
        nameError: ""
      )
    );
  }

  void onLastNameChanged(String value) {
    _Initial(
        isFormValid: true,
        lastNameError: "",
        nameError: ""
    );
  }

  void onSubmit() async {
    var result = await _operationsUseCase.makeUserUpdate(
        UpdateUserRequest(userEmail: model.userEmail,
            userName: userName.text, userLastName:
            userLastName.text)
    );

    result.match((l) {}, (r) {
      emit(_Done());
    }
    );

  }

}

@freezed
class EditUserState with _$EditUserState {
  factory EditUserState.Initial({
    @Default(false) bool isFormValid,
    @Default("")String nameError,
    @Default("")String lastNameError
}) = _Initial;
  factory EditUserState.Done() = _Done;
}