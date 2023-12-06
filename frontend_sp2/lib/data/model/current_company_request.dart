
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_company_request.g.dart';

@JsonSerializable()
class CurrentCompanyRequest extends BaseModel {
  @JsonKey(name: 'currentCompany')
  final int currentCompany;

  CurrentCompanyRequest({
    required this.currentCompany
  });

  factory CurrentCompanyRequest.fromJson(Map<String, dynamic> json) =>
      _$CurrentCompanyRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CurrentCompanyRequestToJson(this);

}