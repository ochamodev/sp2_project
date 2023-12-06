
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/theming/img_paths.dart';
import 'package:frontend_sp2/domain/model/company_item_model.dart';

class CompanyItem extends StatelessWidget {
  final CompanyItemModel model;
  final Function() onClick;

  const CompanyItem({required this.model, required this.onClick, super.key});@override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 50,
      child: Card(
        elevation: 3,
        child: InkWell(
          child: Column(
            children: [
              Image.asset(
                ImgPaths.buildingIcon,
                height: 200,
                width: 200,
              ),
              Flexible(
                child: Text(
                  model.companyName,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: "NIT: ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan>[
                      TextSpan(text: model.nit),
                    ]
                  )
                ),
              )
            ],
          ),
          onTap: () {
            onClick();
          },
        ),
      ),
    );
  }

}