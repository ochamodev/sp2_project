import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';

class _DashboardCardHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  final double borderRadius, iconSize = 30;
  final Color gradientEndColor = const Color(0xffffc2cf);
  const _DashboardCardHeader(
      {super.key,
        required this.label,
        required this.icon,
        required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.defaultRedColor,
            gradientEndColor,
          ],
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            topLeft: Radius.circular(borderRadius)),
        border: Border.all(
            width: 1, color: Colors.transparent, style: BorderStyle.none),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Icon(
            icon,
            size: iconSize,
          ),
        ],
      ),
    );
  }
}

class _DashboardCardBody extends StatelessWidget {
  final String value;
  final double maxCardHeight = 150, borderRadius;
  const _DashboardCardBody({required this.value, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxCardHeight,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.defaultLightWhiteColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius)),
          border: Border.all(
              width: 1, color: Colors.transparent, style: BorderStyle.none),
        ),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

class DashboardCardSimple extends StatelessWidget {
  final double maxCardWidth = 300, borderRadius = 16;
  final String label, value;
  final IconData icon;
  const DashboardCardSimple(
      {required this.label,
        required this.icon,
        required this.value,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxCardWidth,
      child: Column(
        children: [
          _DashboardCardHeader(
              label: label, icon: icon, borderRadius: borderRadius),
          _DashboardCardBody(value: value, borderRadius: borderRadius),
        ],
      ),
    );
  }
}
