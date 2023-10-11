

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/core/inputs/email_input.dart';
import 'package:frontend_sp2/core/inputs/text_field_input.dart';
import 'package:frontend_sp2/data/model/register_user_request.dart';
import 'package:frontend_sp2/domain/register_user_use_case.dart';

part 'register_user_cubit.freezed.dart';

class RegisterUserCubit extends Cubit<RegisterUserFormState> {
  final RegisterUserUseCase _useCase;

  TextEditingController userEmailCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userLastNameCtrl = TextEditingController();
  TextEditingController userCompanyNitCtrl = TextEditingController();
  TextEditingController userCompanyNameCtrl = TextEditingController();

  RegisterUserCubit(this._useCase) : super(_Initial());

  void resetForm() {
    userEmailCtrl.text = "";
    userPasswordCtrl.text = "";
    userNameCtrl.text = "";
    userLastNameCtrl.text = "";
    userCompanyNitCtrl.text = "";
    userCompanyNameCtrl.text = "";
    emit(_Initial());
  }

  void onNameChanged(String value) {
    final nameInput = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        nameInput: nameInput,
        formIsValid: Formz.validate([
          state.email,
          state.password,
          nameInput,
          state.lastNameInput,
          state.companyNameInput,
          state.nitInput,
        ])
    ));
  }

  void onLastNameChanged(String value) {
    final lastNameInput = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        lastNameInput: lastNameInput,
        formIsValid: Formz.validate([
          state.email,
          state.password,
          state.nameInput,
          lastNameInput,
          state.companyNameInput,
          state.nitInput,
        ])
    ));
  }

  void onNitInputChanged(String value) {
    final nitInput = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        nitInput: nitInput,
        formIsValid: Formz.validate([
          state.email,
          state.password,
          state.nameInput,
          state.lastNameInput,
          state.companyNameInput,
          nitInput
        ])
    ));
  }

  void onCompanyNameChanged(String value) {
    final companyInput = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        companyNameInput: companyInput,
        formIsValid: Formz.validate([
          state.email,
          state.password,
          state.nameInput,
          state.lastNameInput,
          companyInput,
          state.nitInput,
        ])
    ));
  }

  void showPassword() {
    emit(state.copyWith(
        obscurePassword: !state.obscurePassword
    ));
  }

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);

    emit(state.copyWith(
        email: email,
        formIsValid: Formz.validate([
          email,
          state.password,
          state.nameInput,
          state.lastNameInput,
          state.companyNameInput,
          state.nitInput,
        ])
    ));
  }

  void onPasswordChanged(String value) {
    final password = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        password: password,
        formIsValid: Formz.validate([
          password,
          state.password,
          state.nameInput,
          state.lastNameInput,
          state.companyNameInput,
          state.nitInput,
        ])
    ));
  }

  Future<void> submitForm() async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress
      )
    );

    Future.delayed(const Duration(seconds: 2)).then((val) async {
      final email = state.email.value;
      final password = state.password.value;
      final name = state.nameInput.value;
      final lastName = state.lastNameInput.value;
      final nit = state.nitInput.value;
      final companyName = state.companyNameInput.value;
      final request = RegisterUserRequest(
          userEmail: email,
          password: password,
          name: name,
          lastName: lastName,
          nitEmpresa: nit,
          nameEmpresa: companyName
      );
      final result = await _useCase.call(request);
      result.match((error) {
        emit(
            state.copyWith(
                registerFormStatus: RegisterFormStatusResult.error,
                message: error.respDescription
            )
        );
      }, (result) {
        emit(
          state.copyWith(
            registerFormStatus: RegisterFormStatusResult.success
          )
        );
      });
    });
  }
}

enum RegisterFormStatusResult {
  initial, error, success
}

@freezed
class RegisterUserFormState with _$RegisterUserFormState {
  factory RegisterUserFormState.initial({
    @Default(TextFieldInput.pure()) TextFieldInput nameInput,
    @Default(TextFieldInput.pure()) TextFieldInput lastNameInput,
    @Default(TextFieldInput.pure()) TextFieldInput nitInput,
    @Default(TextFieldInput.pure()) TextFieldInput companyNameInput,
    @Default(EmailInput.pure()) EmailInput email,
    @Default(TextFieldInput.pure()) TextFieldInput password,
    @Default(false) bool formIsValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default("") String message,
    @Default(true) bool obscurePassword,
    @Default(RegisterFormStatusResult.initial) RegisterFormStatusResult registerFormStatus,
  }) = _Initial;
}