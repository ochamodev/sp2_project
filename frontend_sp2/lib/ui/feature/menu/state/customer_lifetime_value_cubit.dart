import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/customer_lifetime_value_use_case.dart';
import 'package:logger/logger.dart';

part 'customer_lifetime_value_cubit.freezed.dart';

class CustomerLifetimeValueCubit extends Cubit<CustomerLifetimeValueScreenState> {
  final CustomerLifetimeValueUseCase _customerLifetimeValueUseCase;
  final Logger _logger;


  CustomerLifetimeValueCubit(this._customerLifetimeValueUseCase, this._logger) : super(_Current());

}

@freezed
class CustomerLifetimeValueScreenState with _$CustomerLifetimeValueScreenState {
  factory CustomerLifetimeValueScreenState.current() = _Current;
}