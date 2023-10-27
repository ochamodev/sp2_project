
import 'package:json_annotation/json_annotation.dart';

part 'year_filters_response.g.dart';

@JsonSerializable()
class YearFiltersResponse {
  @JsonKey(name: "year")
  int year;
  YearFiltersResponse({
    required this.year
  });

  factory YearFiltersResponse.fromJson(Map<String, dynamic> json) =>
      _$YearFiltersResponseFromJson(json);

}