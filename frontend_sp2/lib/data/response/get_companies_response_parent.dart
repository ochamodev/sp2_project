
import 'package:frontend_sp2/data/response/get_company_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_companies_response_parent.g.dart';

@JsonSerializable()
class GetCompaniesResponseParent {
  final List<GetCompanyResponse> companies;
  GetCompaniesResponseParent({
    required this.companies
  });

  factory GetCompaniesResponseParent.fromJson(Map<String, dynamic> json) =>
      _$GetCompaniesResponseParentFromJson(json);

}