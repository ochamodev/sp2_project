
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_users_in_company.g.dart';

@JsonSerializable()
class GetUsersInCompany extends BaseModel {
  @JsonKey(name: 'currentCompany')
  final int currentCompany;

  GetUsersInCompany({
    required this.currentCompany
  });

  factory GetUsersInCompany.fromJson(Map<String, dynamic> json) =>
      _$GetUsersInCompanyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetUsersInCompanyToJson(this);

}