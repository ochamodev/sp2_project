
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/core/theming/img_paths.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';

class CompanyItem extends StatelessWidget {
  final CompanyItemModel model;
  final Function() onClick;

  const CompanyItem({required this.model, required this.onClick, super.key});@override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 3,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Spacer(),
                Flexible(
                  flex: 8,
                  child: Image.asset(
                    ImgPaths.buildingIcon
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Text(
                    model.companyName,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "NIT: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: <TextSpan>[
                        TextSpan(
                          text: model.nit,
                        ),
                      ]
                    )
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          onTap: () {
            onClick();
          },
        ),
      ),
    );
  }

}