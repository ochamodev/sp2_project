
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';
import 'package:frontend_sp2/ui/feature/select_company/state/select_company_cubit.dart';
import 'package:frontend_sp2/ui/feature/select_company/view/company_item.dart';

@RoutePage()
class SelectCompanyScreen extends StatelessWidget {
  const SelectCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SelectCompanyCubit>()..getCompanies(),
      child: const _SelectScreenBody(),
    );
  }

}

class _SelectScreenBody extends StatelessWidget {
  const _SelectScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<SelectCompanyCubit, SelectCompanyScreenState>(
      builder: (context, state) {
        return state.when(
            loading: () {
              return const LinearProgressIndicator();
            },
            empty: () {
              return Center(
                child: Text(
                  "No tienes empresas asignadas",
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            },
            initial: (List<CompanyItemModel> items) {
              return SizedBox(
                height: mediaQuery.height,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Selecciona que empresa quieres consultar:",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: Dimens.itemSeparationHeight,
                      ),
                      Flexible(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: mediaQuery.height * 0.30,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            var item = items[index];
                            return CompanyItem(
                                model: item,
                                onClick: () {
                                  context.read<SelectCompanyCubit>()
                                      .storeCurrentSelectedCompany(item.id);
                                  AutoRouter.of(context).navigate(const MainMenuRoute());
                                }
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }

}