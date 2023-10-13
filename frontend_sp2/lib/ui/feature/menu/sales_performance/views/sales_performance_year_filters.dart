
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/state/sales_performance_cubit.dart';



class _YearFilter extends StatelessWidget {
  final String label;
  final Function(bool) onSelected;
  final bool selected;

  const _YearFilter({
    super.key,
    required this.label,
    required this.onSelected,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
      selected: selected,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(side: BorderSide()),
      selectedColor: AppColors.defaultRedColor,
    );
  }

}

class SalesPerformanceYearFilters extends StatelessWidget {
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
                  child: _YearFilter(
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