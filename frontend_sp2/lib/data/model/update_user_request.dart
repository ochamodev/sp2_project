
import 'package:flutter/cupertino.dart';
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest extends BaseModel {
  final String userEmail;
  final String userName;
  final String userLastName;

  UpdateUserRequest({
    required this.userEmail,
    required this.userName,
    required this.userLastName,
});

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateUserRequestToJson(this);
  }




}