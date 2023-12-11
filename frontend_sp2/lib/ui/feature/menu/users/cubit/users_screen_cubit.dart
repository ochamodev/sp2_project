
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/get_users_in_company_use_case.dart';
import 'package:frontend_sp2/domain/user_model.dart';
import 'package:logger/logger.dart';

part 'users_screen_cubit.freezed.dart';

class UsersScreenCubit extends Cubit<UsersScreenState> {
  final GetUsersInCompanyUseCase _getUsersInCompanyUseCase;
  final Logger _logger;
  UsersScreenCubit(this._getUsersInCompanyUseCase, this._logger) : super(_Loading());

  void getUsers() async {
    var result = await _getUsersInCompanyUseCase();

    result.match((error) {
      _logger.log(Level.error, error.respDescription);
    }, (result) {
      emit(
        _Loaded(items: result)
      );
    });
  }

}

@freezed
class UsersScreenState with _$UsersScreenState {
  factory UsersScreenState.loading() = _Loading;
  factory UsersScreenState.loaded({
    required List<UserModel> items
  }) = _Loaded;

}