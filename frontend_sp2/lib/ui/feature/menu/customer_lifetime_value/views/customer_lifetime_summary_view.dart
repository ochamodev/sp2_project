
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/domain/model/customer_lifetime_value/summary_card_model.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/views/customer_lifetime_summary_card.dart';

class CustomerLifetimeSummaryView extends StatelessWidget {
  final List<SummaryCardModel> _items = [
    SummaryCardModel(title: "Promedio mes activo", information: "3"),
    SummaryCardModel(title: "Total clientes", information: "450"),
    SummaryCardModel(title: "Promedio compra", information: "\$145"),
    SummaryCardModel(title: "Promedio frecuencia", information: "4 / mes")
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
              itemCount: _items.length,
              itemBuilder: (BuildContext context, index) {
                var it = _items[index];
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
  }

}