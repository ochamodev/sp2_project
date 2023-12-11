
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_user_to_company_request.g.dart';

@JsonSerializable()
class AddUserToCompanyRequest extends BaseModel {
  final String userEmail;
  final String userName;
  final String userPassword;
  final String userLastName;
  final bool searchByUser;
  final int companyId;

  AddUserToCompanyRequest({
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    required this.companyId,
    required this.searchByUser
});

  @override
  Map<String, dynamic> toJson() {
    return _$AddUserToCompanyRequestToJson(this);
  }

}