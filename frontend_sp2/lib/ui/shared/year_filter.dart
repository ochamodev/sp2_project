
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';

class YearFilter extends StatelessWidget {
  final String label;
  final Function(bool) onSelected;
  final bool selected;

  const YearFilter({
    super.key,
    required this.label,
    required this.onSelected,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: selected ? Colors.white : Colors.black
        ),
      ),
      onSelected: onSelected,
      selected: selected,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(side: BorderSide()),
      selectedColor: AppColors.defaultRedColor,

    );
  }

}