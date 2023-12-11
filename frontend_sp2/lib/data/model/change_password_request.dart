

import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest extends BaseModel {
  final String oldPassword;
  final String newPassword;
  final String userEmail;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.userEmail
});

  @override
  Map<String, dynamic> toJson() {
    return _$ChangePasswordRequestToJson(this);
  }

}