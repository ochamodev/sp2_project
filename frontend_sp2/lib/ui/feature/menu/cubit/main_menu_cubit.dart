
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/logout_use_case.dart';


part 'main_menu_cubit.freezed.dart';

class MainMenuCubit extends Cubit<MainMenuCubitState> {
  final LogoutUseCase _logoutUseCase;
  MainMenuCubit(this._logoutUseCase) : super(_Initial());

  void logout() {
    _logoutUseCase();
    emit(_Logout());
  }

}

@freezed
class MainMenuCubitState with _$MainMenuCubitState {
  factory MainMenuCubitState.initial() = _Initial;
  factory MainMenuCubitState.logout() = _Logout;

}