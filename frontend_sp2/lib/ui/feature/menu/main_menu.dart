import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/app_colors.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/cubit/main_menu_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/customer_lifetime_value/customer_lifetime_value_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/file_upload/file_upload_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/sales_performance_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/rfc/rfc_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/users/users_screen.dart';
import 'package:frontend_sp2/ui/feature/profile/profile_screen.dart';

import 'customer_retention/customer_retention_screen.dart';

@RoutePage()
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MainMenuScreen> {
  late PageController pageController;
  int _selectedIndex = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MainMenuCubit>(),
      child: BlocBuilder<MainMenuCubit, MainMenuCubitState>(
        bloc: getIt<MainMenuCubit>(),
        buildWhen: (previous, current) {
          return false;
        },
        builder: (context, state) {
          final mediaQuery = MediaQuery.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Prometeus Analytics"),
              centerTitle: true,
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  selectedIconTheme: Theme.of(context)
                      .iconTheme
                      .copyWith(color:  Theme.of(context).colorScheme.primary),
                  selectedLabelTextStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    });
                  },
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      label: Text('Subir archivos'),
                      icon: Icon(Icons.upload_file),
                    ),
                    NavigationRailDestination(
                      label: Text('Usuarios'),
                      icon: Icon(Icons.person),
                    ),
                    NavigationRailDestination(
                      label: Text('Desempeño de Ventas'),
                      icon: Icon(Icons.point_of_sale_sharp),
                    ),
                    NavigationRailDestination(
                      label: Text('Valor Generado por Cliente'),
                      icon: Icon(Icons.supervisor_account),
                    ),
                    NavigationRailDestination(
                      label: Text('Retención de Clientes'),
                      icon: Icon(Icons.contact_emergency),
                      // icon: Icon(Icons.wifi_protected_setup),
                    ),
                    NavigationRailDestination(
                      label: Text('Segmentación de Clientes'),
                      icon: Icon(Icons.safety_divider),
                    ),
                    NavigationRailDestination(
                      label: Text('Cerrar sesión'),
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 2),
                BlocListener<MainMenuCubit, MainMenuCubitState>(
                  listener: (BuildContext context, MainMenuCubitState state) {
                    state.when(
                        initial: () {},
                        logout: () {
                          AutoRouter.of(context).replace(const HomeRoute());
                        });
                  },
                  child: Expanded(
                    child: PageView(
                      controller: pageController,
                      children: [
                        const FileUploadScreen(),
                        const UsersScreen(),
                        const SalesPerformanceScreen(),
                        const CustomerLifetimeValueScreen(),
                        const CustomerRetentionScreen(),
                        const RFCScreen(),
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "¿Desea cerrar sesión?",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(
                                    height: Dimens.itemSeparationHeight),
                                ElevatedButton(
                                    onPressed: () {
                                      context.read<MainMenuCubit>().logout();
                                    },
                                    style:  ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.radiusButton)),
                                        fixedSize: Size(mediaQuery.size.width * 0.25,
                                            Dimens.fixedButtonHeight),
                                        backgroundColor:
                                        AppColors.deepPurple),
                                    child: const Text("Salir")),
                                const SizedBox(
                                    height: Dimens.itemSeparationHeight),
                                ElevatedButton(
                                    onPressed: () {
                                      pageController.animateToPage(0,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.ease);
                                      _selectedIndex = 0;
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.radiusButton)),
                                        fixedSize: Size(mediaQuery.size.width * 0.25,
                                            Dimens.fixedButtonHeight),
                                        backgroundColor: AppColors.lightOrange),
                                    child: const Text("Cancelar"))
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
