
import 'package:frontend_sp2/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_code.g.dart';

@JsonSerializable()
class ResponseCode extends BaseModel {
  final String respCode;
  final String respDescription;

  ResponseCode({
    required this.respCode,
    required this.respDescription
  });

  @override
  Map<String, dynamic> toJson() => _$ResponseCodeToJson(this);

  factory ResponseCode.fromJson(Map<String, dynamic> json) =>
      _$ResponseCodeFromJson(json);


}