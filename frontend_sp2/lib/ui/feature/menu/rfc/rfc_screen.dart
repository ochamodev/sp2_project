
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/rfc/views/rfc_scatter_plot.dart';
import 'package:frontend_sp2/ui/feature/menu/rfc/views/rfc_summary_view.dart';

import 'package:frontend_sp2/ui/feature/menu/state/rfc_cubit.dart';
import 'package:frontend_sp2/ui/shared/legend_widget.dart';
import 'package:frontend_sp2/utils/formatting.dart';


class RFCScreen extends StatelessWidget {
  const RFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RFCCubit>()..getRFC(),
      child: const RFCBody(),
    );
  }

}

class RFCBody extends StatelessWidget{
  const RFCBody({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SizedBox(
      width: media.size.width,
      height: media.size.height,
      child: BlocBuilder<RFCCubit, RFCScreenState>(
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
                      "Segmentación de Clientes",
                      // style: Theme.of(context).textTheme.headline4,
                      style: TextStyle(
                        fontSize: 50.0,
                        color: AppColors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: Dimens.topSeparation),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resumen",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Tooltip(
                          message: "Promedio histórico que describe el comportamiento de todos los clientes.",
                          child: Icon(Icons.info, color: AppColors.deepPurple,),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.topSeparation),
                    RFCSummaryView(),
                    const SizedBox(height: Dimens.topSeparation),

                    const SizedBox(height: Dimens.itemSeparationHeight),
                    Flexible(
                      child: ListView.builder(
                        itemCount: model.reportList.length,
                        itemBuilder: (context, index) {
                          var item = model.reportList[index];
                          var clusterName = item.uniqueClusterNames[index % item.uniqueClusterNames.length];
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: Column(
                                children: [
                                  Text(
                                    "Análisis de compras por Segmento de Cliente $clusterName",
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                      height: Dimens.itemSeparationHeight),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        width: media.size.width * 0.25,
                                        child: RFCScatterPlot(
                                          xValues: item.frequencyValues,
                                          yValues: item.recencyValues,
                                          xTitle: 'Frecuencia de compras',
                                          yTitle: 'Días desde última compra',
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimens.itemSeparationHeight),
                                      SizedBox(
                                        height: 300,
                                        width: media.size.width * 0.25,
                                        child: RFCScatterPlot(
                                          xValues: item.frequencyValues,
                                          yValues: item.monetaryValues,
                                          xTitle: 'Frecuencia de compras',
                                          yTitle: 'Monto facturado',
                                        ),
                                      ),
                                      const SizedBox(
                                          height: Dimens.itemSeparationHeight),
                                      SizedBox(
                                        height: 300,
                                        width: media.size.width * 0.25,
                                        child: RFCScatterPlot(
                                          xValues: item.recencyValues,
                                          yValues: item.monetaryValues,
                                          xTitle: 'Días desde última compra',
                                          yTitle: 'Monto facturado',
                                        ),
                                      ),
                                    ],
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