
import 'package:frontend_sp2/data/response/year_filters_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'year_filters_response_parent.g.dart';

@JsonSerializable()
class YearFiltersResponseParent {
  final List<YearFiltersResponse> filters;

  YearFiltersResponseParent({
    required this.filters
  });

  factory YearFiltersResponseParent.fromJson(Map<String, dynamic> json) =>
  _$YearFiltersResponseParentFromJson(json);

}