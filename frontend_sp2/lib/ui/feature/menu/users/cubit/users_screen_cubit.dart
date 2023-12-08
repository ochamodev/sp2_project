
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_screen_cubit.freezed.dart';

class UsersScreenCubit extends Cubit<UsersScreenState> {
  UsersScreenCubit(super.initialState);

}

@freezed
class UsersScreenState with _$UsersScreenState {
  factory UsersScreenState.loading() = _Loading;
  factory UsersScreenState.loaded() = _Loaded;

}