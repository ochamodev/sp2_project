
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/summary_card_model.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/views/customer_lifetime_summary_card.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';

class CustomerLifetimeSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<CustomerLifetimeValueCubit, CustomerLifetimeValueScreenState>(
      builder: (context, state) {
        return state.when(
          current: (model) {
            return SizedBox(
                height: mediaQuery.size.height * 0.21,
                width: mediaQuery.size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Card(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: mediaQuery.size.height * 0.10
                        ),
                        itemCount: model.generalSummary.length,
                        itemBuilder: (BuildContext context, index) {
                          var it = model.generalSummary[index];
                          Border border = const Border();
                          Color borderColor = AppColors.hotPink;
                          BorderSide borderSide = BorderSide(width: 1.5, color: borderColor);
                          if (index == 0) {
                            border = Border(
                                right: borderSide,
                                bottom: borderSide
                            );
                          }
                          if (index == 1) {
                            border = Border(
                                bottom: borderSide
                            );
                          }
                          if (index == 2) {
                            border = Border(
                                right: borderSide
                            );
                          }
                          return CustomerLifetimeSummaryCard(
                            model: it,
                            border: border,
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