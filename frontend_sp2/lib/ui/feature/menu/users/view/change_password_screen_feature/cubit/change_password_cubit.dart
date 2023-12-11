import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/user_operations_use_case.dart';

part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserOperationsUseCase _useCase;
  ChangePasswordCubit(this._useCase) : super(_Initial());

}

@freezed
class ChangePasswordState with _$ChangePasswordState {

  factory ChangePasswordState.initial({
  @Default("") String error
}) = _Initial;

}