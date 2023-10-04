
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/formatting.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/core/ui/chart_component.dart';
import 'package:frontend_sp2/ui/feature/menu/file_upload/views/sales_performance_block_info_item.dart';
import 'package:frontend_sp2/ui/feature/menu/file_upload/views/sales_performance_boards.dart';

class SalesPerformanceScreen extends StatelessWidget {
  const SalesPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SizedBox(
      height: media.size.height,
      width: media.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          children: [
            const SizedBox(height: Dimens.topSeparation),
            Text(
              "Filtrar por año",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: Dimens.itemSeparationHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _YearFilter(
                  label: "2020",
                  onSelected: (value) {

                  },
                  selected: true,
                ),
                const SizedBox(width: Dimens.itemSeparationHeight),
                _YearFilter(
                  label: "2021",
                  onSelected: (value) {

                  },
                  selected: true,
                ),
                const SizedBox(width: Dimens.itemSeparationHeight),
                _YearFilter(
                  label: "2022",
                  onSelected: (value) {

                  },
                  selected: true,
                ),
              ],
            ),
            SizedBox(height: Dimens.itemSeparationHeight),
            SingleChildScrollView(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SalesPerformanceBoards(
                        annualSales: 1000.40,
                        avgAnnualSales: 1000.40,
                        currentMonthTotal: 1000.40,
                        monthlyVariance: 1000.40,
                      ),
                      SizedBox(height: Dimens.itemSeparationHeight),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
