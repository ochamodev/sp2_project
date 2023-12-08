
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String userEmail;
  final String userLastName;
  final String userName;

  UserResponse({
    required this.id,
    required this.userEmail,
    required this.userLastName,
    required this.userName,
});
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}