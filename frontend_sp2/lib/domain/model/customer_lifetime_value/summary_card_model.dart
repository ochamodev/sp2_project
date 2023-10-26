
import 'package:equatable/equatable.dart';

class SummaryCardModel extends Equatable {
  final String title;
  final String information;

  const SummaryCardModel({
    required this.title,
    required this.information
  });

  @override
  List<Object?> get props => [title, information];



}