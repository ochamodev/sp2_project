
import 'package:frontend_sp2/data/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class GetUsersResponse {
  final List<UserResponse> users;

  GetUsersResponse({required this.users});

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);
}