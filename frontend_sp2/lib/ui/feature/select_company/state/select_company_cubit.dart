
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/shared_prefs_keys.dart';
import 'package:frontend_sp2/domain/get_companies_use_case.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'select_company_cubit.freezed.dart';

class SelectCompanyCubit extends Cubit<SelectCompanyScreenState> {
  final GetCompaniesUseCase _companiesUseCase;
  final SharedPreferences _sharedPreferences;
  SelectCompanyCubit(this._companiesUseCase, this._sharedPreferences) : super(_Loading());

  void getCompanies() async {
    var result = await _companiesUseCase();
    result.match(
            (l) => {},
            (r) => {
              emit(_Initial(r))
            });
  }
  
  void storeCurrentSelectedCompany(int company) async {
    _sharedPreferences.setInt(SharedPrefsKeys.currentSelectedCompany, company);
  }
  
}

@freezed
class SelectCompanyScreenState with _$SelectCompanyScreenState {
  factory SelectCompanyScreenState.loading() = _Loading;
  factory SelectCompanyScreenState.initial(
      List<CompanyItemModel> companies
  ) = _Initial;
  factory SelectCompanyScreenState.empty() = _Empty;
}