
import 'package:json_annotation/json_annotation.dart';

part 'year_filters.g.dart';

@JsonSerializable()
class YearFilters {
  @JsonKey(name: "year")
  int year;
  YearFilters({
    required this.year
  });

  factory YearFilters.fromJson(Map<String, dynamic> json) =>
      _$YearFiltersFromJson(json);

}