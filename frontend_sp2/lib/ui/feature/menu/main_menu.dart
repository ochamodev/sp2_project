import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/theming/dimens.dart';
import 'package:frontend_sp2/ui/feature/menu/cubit/main_menu_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/file_upload/file_upload_screen.dart';
import 'package:frontend_sp2/ui/feature/menu/sales_performance/sales_performance_screen.dart';

@RoutePage()
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MyMenuPageState createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MainMenuScreen> {
  late PageController pageController;

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
          return Scaffold(
            appBar: AppBar(
              title: const Text("Menu principal"),
              centerTitle: true,
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationRail(
                  selectedIndex: 0,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (index) {
                    setState(() {
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
                      label: Text('Sales performance'),
                      icon: Icon(Icons.supervisor_account),
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
                        const SalesPerformanceScreen(),
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
                                    child: const Text("Salir")),
                                const SizedBox(
                                    height: Dimens.itemSeparationHeight),
                                ElevatedButton(
                                    onPressed: () {
                                      pageController.animateToPage(0,
                                          duration: const Duration(milliseconds: 200),
                                          curve: Curves.ease);
                                    },
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
