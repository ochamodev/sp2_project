

import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/get_companies_caller.dart';
import 'package:frontend_sp2/data/response/response_code.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';

class GetCompaniesUseCase {
  final GetCompaniesCaller _companiesCaller;

  GetCompaniesUseCase(this._companiesCaller);

  Future<Either<ResponseCode, List<CompanyItemModel>>> call() async {
    var result = await _companiesCaller.getCompanies();
    Either<ResponseCode, List<CompanyItemModel>> response =
    result.match((l) {
      return Either.left(l);
    }, (r) {
      var items = r.companies.map((e) {
        return CompanyItemModel(
        nit: e.nit,
        id: e.id,
        companyName: e.nameEmitter);
      }).toList();
      return Either.right(items);
    });
    return response;
  }

}