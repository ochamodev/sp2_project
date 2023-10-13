
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/anim_paths.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_boards.dart';
import '../state/sales_performance_cubit.dart';

import 'package:lottie/lottie.dart';

class SalesPerformanceScreen extends StatelessWidget {
  const SalesPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SalesPerformanceCubit>(),
        child: SalesPerformancenBody(),
    );
  }
}

class SalesPerformancenBody extends StatelessWidget {
  SalesPerformanceBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: BlocBuilder<SalesPerformanceCubit, SalesPerformanceScreenState>(
        buildWhen: (previousState, state) => previousState != state,
        builder: (BuildContext context, state) {
          return state.when() {
            initial: () {
              return const SizedBox();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          };
        },
      ),
    );
  }
}








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
