
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/views/customer_lifetime_summary_view.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';

class CustomerLifetimeValueScreen extends StatelessWidget {
  const CustomerLifetimeValueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerLifetimeValueCubit>(),
      child: const CustomerLifetimeValueBody(),
    );
  }
}

class CustomerLifetimeValueBody extends StatelessWidget {
  const CustomerLifetimeValueBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: Dimens.topSeparation),
            Text(
              "Resumen",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: Dimens.topSeparation),
            CustomerLifetimeSummaryView()
          ],
        ),
      ),
    );
  }

}