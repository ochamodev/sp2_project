
import 'package:equatable/equatable.dart';

class YearFilterModel extends Equatable {
  String year;
  bool selected;
  YearFilterModel({
    required this.year,
    required this.selected
  });

  @override
  List<Object?> get props => [year, selected];
}