import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/anim_paths.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_bar_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_boards.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_line_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_year_filters.dart';
import '../state/sales_performance_cubit.dart';

import 'package:lottie/lottie.dart';

class SalesPerformanceScreen extends StatelessWidget {
  const SalesPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesPerformanceCubit>()..getSalesPerformance(),
      child: SalesPerformanceBody(),
    );
  }
}

class SalesPerformanceBody extends StatelessWidget {
  SalesPerformanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SalesPerformanceCubit, SalesPerformanceScreenState>(
          builder: (BuildContext context, state) {
            return state.when(current: (model) {
              final media = MediaQuery.of(context);
              if (model != null) {
                return SizedBox(
                  height: media.size.height,
                  width: media.size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimens.topSeparation),
                        Text(
                          "Filtrar por año",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: Dimens.itemSeparationHeight),
                        SalesPerformanceYearFilters(),
                        const SizedBox(height: Dimens.itemSeparationHeight),
                        Flexible(
                          child: ListView.builder(
                            itemCount: model.salesPerformanceElements.length,
                            itemBuilder: (context, index) {
                              var item = model.salesPerformanceElements[index];
                              return Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Año ${item.year}",
                                        style: Theme.of(context).textTheme.headline4,
                                      ),
                                      SalesPerformanceBoards(
                                        annualSales: double.parse(item.amount),
                                        avgAnnualSales: item.yearAvg,
                                        currentMonthTotal: item.totalFinalMonth,
                                        monthlyVariance: 1000.40,
                                      ),
                                      const SizedBox(
                                          height: Dimens.itemSeparationHeight),
                                      SizedBox(
                                        height: 300,
                                        width: media.size.width * 0.75,
                                        child: SalesPerformanceBarChart(
                                            months: item.months,
                                            sales: item.amounts
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimens.itemSeparationHeight),
                                      SizedBox(
                                        height: 300,
                                        width: media.size.width * 0.75,
                                        child: SalesPerformanceLineChart(
                                            months: item.months,
                                            salesQuantity: item.monthlyQuantity
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimens.itemSeparationHeight),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }, loading: () {
              return CircularProgressIndicator();
            });
          }),
    );
  }
}
