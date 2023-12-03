
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';
import 'package:frontend_sp2/ui/feature/select_company/view/company_item.dart';

@RoutePage()
class SelectCompanyScreen extends StatelessWidget {
  const SelectCompanyScreen({super.key});

  final List<CompanyItemModel> items = const [
    CompanyItemModel(nit: "123", companyName: "IMPORTADORA EDEN, SOCIEDAD ANONIMA"),
    CompanyItemModel(nit: "123", companyName: "IMPORTADORA EDEN, SOCIEDAD ANONIMA"),
    CompanyItemModel(nit: "123", companyName: "IMPORTADORA EDEN, SOCIEDAD ANONIMA"),
    CompanyItemModel(nit: "123", companyName: "IMPORTADORA EDEN, SOCIEDAD ANONIMA"),

  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
                  return CompanyItem(model: item, onClick: () {}
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}