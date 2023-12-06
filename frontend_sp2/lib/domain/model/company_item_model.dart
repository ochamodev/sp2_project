
import 'package:equatable/equatable.dart';

class CompanyItemModel extends Equatable {
  final int id;
  final String nit;
  final String companyName;

  const CompanyItemModel({
    required this.id,
    required this.nit,
    required this.companyName
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id, nit, companyName
  ];

}