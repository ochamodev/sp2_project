
import 'package:json_annotation/json_annotation.dart';

part 'get_company_response.g.dart';

@JsonSerializable()
class GetCompanyResponse {
  final int id;
  final String nit;
  final String nameEmitter;

  GetCompanyResponse({
    required this.id,
    required this.nit,
    required this.nameEmitter
});

  factory GetCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCompanyResponseFromJson(json);
}