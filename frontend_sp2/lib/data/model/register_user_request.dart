
import 'package:frontend_sp2/data/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest extends BaseModel {
  @JsonKey(name: "userEmail")
  final String userEmail;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "nitEmpresa")
  final String nitEmpresa;
  @JsonKey(name: "nameEmpresa")
  final String nameEmpresa;

  RegisterUserRequest({
    required this.userEmail,
    required this.password,
    required this.name,
    required this.lastName,
    required this.nitEmpresa,
    required this.nameEmpresa
  });

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
