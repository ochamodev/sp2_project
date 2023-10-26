
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/customer_lifetime_value_caller.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:logger/logger.dart';

class CustomerLifetimeValueUseCase {
  final Logger _logger;
  final CustomerLifetimeValueCaller _customerLifetimeValueCaller;
  CustomerLifetimeValueUseCase(this._logger, this._customerLifetimeValueCaller);

  Future<Either<ResponseCode, dynamic>?> call() async {
    var callResult = await _customerLifetimeValueCaller.getCustomerValue();
    return null;
  }

}