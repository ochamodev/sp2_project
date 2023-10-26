import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/summary_card_model.dart';

class CustomerLifetimeSummaryCard extends StatelessWidget {
  final SummaryCardModel model;
  final Border border;
  const CustomerLifetimeSummaryCard({super.key, required this.model, required this.border});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height,
      decoration: BoxDecoration(
        border: border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            model.title,
            style: Theme.of(context).textTheme.headline6,
          ),

          Text(
            model.information,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
