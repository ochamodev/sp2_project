
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/views/sales_performance_block_info_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/ui/feature/menu/state/rfc_cubit.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_summary_card_model.dart';


class RFCCard extends StatelessWidget {
  final SummaryCardModel model;

  const RFCCard({
    super.key,
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 40,
      children: [
        DashboardCardSimple(
            label: model.title,
            value: model.information,
            icon: Icons.info
        ),
      ],
    );
  }
}

class RFCSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<RFCCubit, RFCScreenState>(
      builder: (context, state) {
        return state.when(
            current: (model) {
              return SizedBox(
                  height: mediaQuery.size.height * 0.3,
                  width: mediaQuery.size.width * 0.80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Card(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: mediaQuery.size.height * 0.20
                          ),
                          itemCount: model.generalSummary.length,
                          itemBuilder: (BuildContext context, index) {
                            var it = model.generalSummary[index];
                            return RFCCard(
                              model: it,
                            );
                          }),
                    ),
                  )
              );
            },
            loading: () {
              return const SizedBox();
            }
        );
      },
    );
  }

}