
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/views/customer_lifetime_summary_view.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/views/customer_lifetime_value_year_filters.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_bar_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_line_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_year_filters.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';

class CustomerLifetimeValueScreen extends StatelessWidget {
  const CustomerLifetimeValueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerLifetimeValueCubit>()..getCustomerLifetimeValue(),
      child: const CustomerLifetimeValueBody(),
    );
  }
}

class CustomerLifetimeValueBody extends StatelessWidget {
  const CustomerLifetimeValueBody({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SizedBox(
      width: media.size.width,
      height: media.size.height,
      child: BlocBuilder<CustomerLifetimeValueCubit, CustomerLifetimeValueScreenState>(
        buildWhen: (p, c) {
          return true;
        },
        builder: (context, state) {
          return state.when(
            current: (model) {
              return Column(
                children: [
                  const SizedBox(height: Dimens.topSeparation),
                  Text(
                    "Resumen",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: Dimens.topSeparation),
                  CustomerLifetimeSummaryView(),
                  const SizedBox(height: Dimens.topSeparation),
                  Text(
                    "Filtrar por año",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: Dimens.itemSeparationHeight),
                  const CustomerLifetimeValueYearFilters(),
                  const SizedBox(height: Dimens.itemSeparationHeight),
                  Flexible(
                    child: ListView.builder(
                      itemCount: model.reportList.length,

                      itemBuilder: (context, index) {
                        var item = model.reportList[index];
                        return Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  "Valor promedio generado por cliente ${item.year}",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(
                                    height: Dimens.itemSeparationHeight),
                                SizedBox(
                                  height: 300,
                                  width: media.size.width * 0.75,
                                  child: SalesPerformanceBarChart(
                                      months: item.months,
                                      sales: item.customerValues
                                  ),
                                ),
                                const SizedBox(
                                    height: Dimens.itemSeparationHeight),
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
              );
            },
            loading: () {
              return const SizedBox();
            }
          );
        },
      ),
    );
  }

}