
import 'package:auto_route/auto_route.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/domain/user_authenticated_use_case.dart';

class MainMenuGuard extends AutoRouteGuard {
  final UserAuthenticatedUseCase _useCase;

  MainMenuGuard(this._useCase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool authenticated = await _useCase.isUserAuthenticated();

    if (authenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const HomeRoute());
    }

  }

}