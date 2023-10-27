
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/state/sales_performance_cubit.dart';
import 'package:frontend_sp2/ui/shared/year_filter.dart';

class SalesPerformanceYearFilter extends StatelessWidget {
  const SalesPerformanceYearFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesPerformanceCubit, SalesPerformanceScreenState>(
      buildWhen: (p, c) {
        return true;
      },
      builder: (BuildContext context, state) {
        return state.when(current: (model) {
          if (model != null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: model.yearFilters.map((it) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimens.itemSeparationHeight),
                  child: YearFilter(
                    label: it.year,
                    selected: it.selected,
                    onSelected: (e) {
                      context.read<SalesPerformanceCubit>().updateList(it, e);
                    },
                  )
                );
              }).toList(),
            );
          } else {
            return const SizedBox.shrink();
          }
        }, loading: () {
          return const SizedBox.shrink();
        });
      },
    );
  }

}