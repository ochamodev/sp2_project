import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';
import 'package:frontend_sp2/ui/shared/year_filter.dart';

class CustomerLifetimeValueYearFilters extends StatelessWidget {
  const CustomerLifetimeValueYearFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerLifetimeValueCubit,
        CustomerLifetimeValueScreenState>(
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
                            .read<CustomerLifetimeValueCubit>()
                            .updateList(it, e);
                      },
                    ));
              }).toList());
        });
      },
    );
  }
}
