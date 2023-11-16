
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_retention/views/account_retention_stacked_bar_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_retention/views/customer_retention_year_filters.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_retention/views/income_change_stacked_bar_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_bar_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_line_chart.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_year_filters.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_retention_cubit.dart';
import 'package:frontend_sp2/ui/shared/legend_widget.dart';

class CustomerRetentionScreen extends StatelessWidget {
  const CustomerRetentionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerRetentionCubit>()..getCustomerRetention(),
      child: const CustomerRetentionBody(),
    );
  }
}

class CustomerRetentionBody extends StatelessWidget {
  const CustomerRetentionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SizedBox(
      width: media.size.width,
      height: media.size.height,
      child: BlocBuilder<CustomerRetentionCubit, CustomerRetentionScreenState>(
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
                      "Filtrar por año",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: Dimens.itemSeparationHeight),
                    const CustomerRetentionYearFilters(),
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
                                    "Retención de Clientes ${item.year}",
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  LegendsListWidget(
                                    legends: [
                                      Legend("Clientes Nuevos", AppColors.hotPink),
                                      Legend("Clientes Retenidos", AppColors.deepPurple),
                                      Legend("Clientes Cancelados", AppColors.deepPurple),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  SizedBox(
                                    height: 300,
                                    width: media.size.width * 0.75,
                                    child: AccountRetentionBarChart(
                                      months: item.months,
                                      cancelledClients: item.cancelledClients,
                                      newClients: item.newClients,
                                      retainedClients: item.retainedClients,

                                    ),
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  Text(
                                    "Retención de Clientes ${item.year}",
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  LegendsListWidget(
                                    legends: [
                                      Legend("Clientes Nuevos", AppColors.hotPink),
                                      Legend("Clientes Retenidos", AppColors.deepPurple),
                                      Legend("Clientes Cancelados", AppColors.deepPurple),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  SizedBox(
                                    height: 300,
                                    width: media.size.width * 0.75,
                                    child: IncomeChangeBarChart(
                                      months: item.months,
                                      cancelledAmount: item.cancelledAmounts,
                                      newAmount: item.newAmounts,
                                      retainedAmount: item.retainedAmounts,

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