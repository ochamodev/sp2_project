
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/core/inputs/text_field_input.dart';
import 'package:frontend_sp2/core/inputs/email_input.dart';
import 'package:frontend_sp2/domain/login_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  SharedPreferences _sharedPreferences;
  LoginUseCase _loginUseCase;
  LoginCubit(
      this._sharedPreferences,
      this._loginUseCase
  ) : super(_Initial());

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);

    emit(state.copyWith(
      email: email,
      formIsValid: Formz.validate([email, state.password])
    ));
  }

  void onPasswordChanged(String value) {
    final password = TextFieldInput.dirty(value: value);
    emit(state.copyWith(
        password: password,
        formIsValid: Formz.validate([state.email, password])
    ));
  }

  void submitForm() async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      )
    );
    final email = state.email.value;
    final password = state.password.value;

    final result = await _loginUseCase.call(email, password);

    result.match((error) {
    }, (result) {
      state.copyWith(
        status: FormzSubmissionStatus.success
      );
    });
  }

}

enum LoginFormStatus {
  authenticated,
  initial,
  error,
}

@freezed
abstract class LoginState with _$LoginState {
  factory LoginState.initial({
    @Default(EmailInput.pure()) EmailInput email,
    @Default(TextFieldInput.pure()) TextFieldInput password,
    @Default(false) bool formIsValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(LoginFormStatus.initial) LoginFormStatus loginStatus
  }) = _Initial;
}