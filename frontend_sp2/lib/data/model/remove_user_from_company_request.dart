
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remove_user_from_company_request.g.dart';

@JsonSerializable()
class RemoveUserFromCompanyRequest extends BaseModel {
  final int userId;
  final int companyId;

  RemoveUserFromCompanyRequest({
    required this.userId,
    required this.companyId
});

  @override
  Map<String, dynamic> toJson() {
    return _$RemoveUserFromCompanyRequestToJson(this);
  }

}