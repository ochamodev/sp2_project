import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_retention_cubit.dart';
import 'package:frontend_sp2/ui/shared/year_filter.dart';

class CustomerRetentionYearFilters extends StatelessWidget {
  const CustomerRetentionYearFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerRetentionCubit,
        CustomerRetentionScreenState>(
      builder: (BuildContext context, state) {
        return state.when(loading: () {
          return const SizedBox();
        }, current: (model) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: model.yearFilters.map((it) {
                return Padding(
                    padding: const EdgeInsets.only(
                        right: Dimens.itemSeparationHeight),
                    child: YearFilter(
                      label: it.year,
                      selected: it.selected,
                      onSelected: (e) {
                        context
                            .read<CustomerRetentionCubit>()
                            .updateList(it, e);
                      },
                    ));
              }).toList());
        });
      },
    );
  }
}
